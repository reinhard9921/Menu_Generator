import 'package:file_picker/file_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:menu_generator/AddProductDialog.dart';
import 'package:menu_generator/common/widgets/custom_button.dart';
import 'package:menu_generator/models/Categories.dart';
import 'package:menu_generator/models/Pricing.dart';
import 'package:menu_generator/models/Product.dart';
import 'dart:typed_data';
import 'dart:html' as html;
import 'package:syncfusion_flutter_pdf/pdf.dart' as pdfLib;
import 'package:http/http.dart' as http;

class MenuScreen extends StatefulWidget {
  final Map<String, dynamic> userData;

  MenuScreen({required this.userData});
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  List<Categories> column1 = [];
  List<Categories> column2 = [];
  double _transparency = 0.5;
  String Path = "";

  Image? _backgroundImage;
  CroppedFile? croppedFileMain;
  Future<void> _pickImage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      final bytes = result.files.single.bytes!;
      final blob = html.Blob([bytes]);
      final url = html.Url.createObjectUrlFromBlob(blob);

      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: url,
        aspectRatioPresets: [
          CropAspectRatioPreset.ratio4x3,
        ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          ),
          WebUiSettings(
            context: context,
          ),
        ],
      );

      setState(() {
        croppedFileMain = croppedFile;
        _backgroundImage = Image.network(croppedFile!.path);
      });
    }
  }

  void addProductToCategories(
      Categories Categories, String productName, List<Pricing> prices) {
    Categories.products.add(Product(name: productName, prices: prices));
    Navigator.pop(context); // Close the dialog
    setState(() {});
  }

  void _addCategories(int column) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String? CategoriesName;
        return AlertDialog(
          title: Text('Add Category'),
          content: TextField(
            onChanged: (value) {
              CategoriesName = value;
            },
            decoration: InputDecoration(hintText: 'Enter Categories Name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (CategoriesName != null && CategoriesName!.isNotEmpty) {
                  setState(() {
                    if (column == 1)
                      column1
                          .add(Categories(name: CategoriesName!, products: []));
                    else
                      column2
                          .add(Categories(name: CategoriesName!, products: []));
                  });
                  Navigator.pop(context);
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _addProduct(Categories Categories, int column) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddProductDialog(
          onProductAdded: () {
            setState(() {}); // Update UI when product is added
          },
          categories: Categories,
        );
      },
    );
  }

  // Function to export PDF with background image and transparency
  // Function to export PDF with background image and transparency
  Future<void> _exportPDF() async {
    // Create a new PDF document
    final pdf = pdfLib.PdfDocument();

    // Add a new page to the PDF document
    final page = pdf.pages.add();

    // Add background image to the PDF page if available
    if (_backgroundImage != null) {
      // Get the bytes of the image
      final bytes = await _getNetworkImageData(croppedFileMain!.path);

      // Add image to the PDF page, adjusting its size to match the page exactly
      final image = pdfLib.PdfBitmap(bytes);
      page.graphics.drawImage(
        image,
        Rect.fromLTWH(
          0,
          0,
          page.size.width,
          page.size.height,
        ),
      );
    }

    // Add content to the PDF page
    double yOffset = 0;
    final double yOffsetIncrement = 10; // Reduced vertical spacing
    final double paddingLeftCategory = 20; // Padding for category names
    final double maxWidthDescription =
        3 * page.getClientSize().width / 8; // Maximum width for description
    for (var column in [column1, column2]) {
      for (var category in column) {
        // Add category name with padding on the left
        final pdfTextCategory = pdfLib.PdfTextElement(
          text: category.name,
          font: pdfLib.PdfStandardFont(pdfLib.PdfFontFamily.helvetica, 12),
        );
        final layoutResultCategory = pdfTextCategory.draw(
            page: page,
            bounds: Rect.fromLTWH(
                paddingLeftCategory,
                yOffset,
                page.getClientSize().width - paddingLeftCategory,
                page.getClientSize().height));
        yOffset += layoutResultCategory!.bounds!.height + yOffsetIncrement;

        // Add products under the category
        for (var product in category.products) {
          // Add product name
          final pdfTextProduct = pdfLib.PdfTextElement(
            text: product.name,
            font: pdfLib.PdfStandardFont(pdfLib.PdfFontFamily.helvetica, 10),
          );
          final layoutResultProduct = pdfTextProduct.draw(
              page: page,
              bounds: Rect.fromLTWH(
                  1.2 * paddingLeftCategory,
                  yOffset,
                  page.getClientSize().width - 1.2 * paddingLeftCategory,
                  page.getClientSize().height));
          yOffset += layoutResultProduct!.bounds!.height + yOffsetIncrement;

          // Add product description with wrapping
          if (product.desc != null) {
            final pdfTextDescription = pdfLib.PdfTextElement(
              text: product.desc!,
              font: pdfLib.PdfStandardFont(pdfLib.PdfFontFamily.helvetica, 8),
            );
            final layoutResultDescription = pdfTextDescription.draw(
              page: page,
              bounds: Rect.fromLTWH(
                1.2 * paddingLeftCategory, // Left padding for category
                yOffset,
                3 / 8 * page.getClientSize().width, // 3/8 of the page width
                page.getClientSize().height,
              ),
            );
            yOffset +=
                layoutResultDescription!.bounds!.height + yOffsetIncrement;
          }

          // Add product prices with reduced vertical spacing
          for (var price in product.prices) {
            String priceText = '';
            if (price.name != "" && price.name.isEmpty) {
              priceText = '${price.name} : ';
            }
            priceText += 'R${price.price}';

            final pdfTextPrice = pdfLib.PdfTextElement(
              text: priceText,
              font: pdfLib.PdfStandardFont(pdfLib.PdfFontFamily.helvetica, 8),
            );
            final layoutResultPrice = pdfTextPrice.draw(
                page: page,
                bounds: Rect.fromLTWH(
                    1.2 * paddingLeftCategory,
                    yOffset,
                    page.getClientSize().width - 1.2 * paddingLeftCategory,
                    page.getClientSize().height));
            yOffset += layoutResultPrice!.bounds!.height +
                yOffsetIncrement / 2; // Reduced vertical spacing between prices
          }
        }
      }
    }

    // Save the PDF document to a file
    final bytes = pdf.save();
    final blob = html.Blob([Uint8List.fromList(await bytes)]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..setAttribute("download", "menu.pdf")
      ..click();
    html.Url.revokeObjectUrl(url);

    // Show a snackbar to indicate successful PDF export
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('PDF exported successfully!'),
      ),
    );
  }

  Future<Uint8List> _getNetworkImageData(String imageUrl) async {
    final response = await http.get(Uri.parse(imageUrl));
    return response.bodyBytes;
  }

  @override
  Widget build(BuildContext context) {
    // Use widget.userData to access the user data passed from LoginScreen
    // For example: String email = widget.userData['email'];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Create Menu'),
        actions: [
          IconButton(
            icon: Icon(Icons.picture_as_pdf),
            onPressed: _exportPDF,
          ),
        ],
      ),
      body: Column(
        children: [
          // Container(
          //     height: MediaQuery.sizeOf(context).height * 0.1,
          //     width: MediaQuery.sizeOf(context).width,
          //     child: TextButton(
          //         onPressed: () => {_pickImage()}, child: Text("Image"))),
          Container(
            height: MediaQuery.sizeOf(context).height * 0.8,
            width: MediaQuery.sizeOf(context).width,
            child: Stack(
              children: [
                if (_backgroundImage != null)
                  Positioned.fill(
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: _backgroundImage!,
                    ),
                  ),
                Row(
                  children: [
                    Expanded(
                      child: _buildColumn(1),
                    ),
                    Expanded(
                      child: _buildColumn(2),
                    ),
                  ],
                ),
              ],
            ),
          ),
          CustomButton(text: "Upload Image", onTap: () => {_pickImage()})
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addCategories(1),
        child: Icon(Icons.add),
      ),
    );
  }

  void _editProduct(Product product) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String? newName = product.name;
        String? newDesc = product.desc;
        List<Pricing> newPrices = List.from(product.prices);

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Edit Product'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    onChanged: (value) {
                      newName = value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Enter Product Name',
                      hintText: product.name,
                    ),
                  ),
                  TextField(
                    onChanged: (value) {
                      newDesc = value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Enter Product Description',
                      hintText: product.desc ?? 'Optional',
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Prices:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ...newPrices.asMap().entries.map((entry) {
                    int index = entry.key;
                    Pricing price = entry.value;
                    TextEditingController priceNameController =
                        TextEditingController(text: price.name);
                    TextEditingController priceValueController =
                        TextEditingController(text: price.price.toString());
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: TextField(
                              controller: priceNameController,
                              onChanged: (value) {
                                newPrices[index].name = value;
                              },
                              decoration: InputDecoration(
                                labelText: 'Price Name',
                                hintText: 'Optional',
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            flex: 2,
                            child: TextField(
                              controller: priceValueController,
                              onChanged: (value) {
                                newPrices[index].price = value;
                              },
                              decoration: InputDecoration(
                                labelText: 'Price Value',
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        newPrices.add(Pricing(name: '', price: ""));
                      });
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      product.name = newName!;
                      product.desc = newDesc;
                      product.prices = List.from(newPrices);
                    });
                    Navigator.pop(context); // Close the dialog
                    setState(() {});
                  },
                  child: Text('Save'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                    setState(() {});
                  },
                  child: Text('Cancel'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _editCategoryName(Categories category) {
    String? newName = category.name;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Category Name'),
          content: TextField(
            onChanged: (value) {
              newName = value;
            },
            decoration: InputDecoration(
              hintText: category.name,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (newName != null && newName!.isNotEmpty) {
                  setState(() {
                    category.name = newName!;
                  });
                  Navigator.pop(context); // Close the dialog
                }
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildColumn(int column) {
    List<Categories> categories = (column == 1) ? column1 : column2;
    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) {
        Categories category = categories[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(
                category.name,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  _editCategoryName(category);
                },
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: category.products.length,
              itemBuilder: (context, index) {
                Product product = category.products[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              product.name,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            _editProduct(product);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            setState(() {
                              category.products.removeAt(index);
                            });
                          },
                        ),
                      ],
                    ),
                    if (product.desc != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          product.desc!,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: product.prices.map((price) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32.0),
                          child: Text(
                            (price.name != null && price.name.isNotEmpty)
                                ? '${price.name} : R${price.price}'
                                : 'R${price.price}',
                            style: TextStyle(fontSize: 14),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                );
              },
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              child: ElevatedButton(
                onPressed: () => _addProduct(category, column),
                child: Text('Add Product'),
              ),
            ),
            SizedBox(height: 16),
          ],
        );
      },
    );
  }
}
