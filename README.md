# Storm Viewr

Project #1 from HackingWithSwift.com. An app that demonstrates the use of UITableViewController and UIActivityViewController

<img src="https://github.com/igibliss00/StormViewer/blob/master/README_assets/1.png" width="400">
<img src="https://github.com/igibliss00/StormViewer/blob/master/README_assets/2.png" width="400">

## Installing

```
git clone https://github.com/igibliss00/StormViewer.git
```

## TableView

Table view is one of the most widely used user interface element in mobile app development.  UIKit has a type called UITableView that uses three functions to construct a very basic table, which were used in this project:

```
override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return pictures.count
}
```

The numberOfRowsInSection function is to calculate the number of rows that a table should have.  The pictures array contains list of pictures to be displayed on the table so the "count" method of the array returns the number of rows needed in a table.

```
override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
    cell.textLabel?.text = pictures[indexPath.row]
    return cell
}
```
The cellForRowAt function is to indicate what each cell should do or display.  TableView's method called "dequeueReusableCell" takes the cell that goes out of view from the device's viewport and adds to the table that's just about to come into the view, thereby reducing the need to have unnecessary cells using up the resources.  I have set the name of the cell within the table view of Interface Builder to be "Picture", which is why "Picture" is being used as the first parameter.  

For each cell, the text should display the name of the element within the "pictures" array whose index corresponds with the row of the table.

```
override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
        vc.selectedImage = pictures[indexPath.row]
        vc.row = indexPath.row
        vc.total = pictures.count
        navigationController?.pushViewController(vc, animated: true)
    }
}
```
The didSelectRowAt function is to execute what happens when the user selects a particular row within a table. Here I instantiate a view controller from a property called storyboard with a parameter "Detail" as the identifier.  This identifier is the Storyboard ID that was set from the Interface Builder's Identity Inspector.  I set all the properties of the newly created view controller with appropriat information and allow to be pushed to the "Detail". 

## UIActivityViewController

The project demonstrate its ability bring up a panel that allows the selected picture to be saved into the photo gallery or shared on social media

```
@objc func shareTapped() {
    guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
        print("No image found")
        return
    }
    let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
    vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem // for iPad
    present(vc, animated: true)
}
```

This function is then assigned to the button on the right bar button

```
navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
```
