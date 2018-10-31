# uitableview-sticky-header
A single class to control and persist a fixed position of a header view when scrolling through a UITableView.

## Usage

```
class ViewController: UITableViewController {

    @IBOutlet var myHeaderView: UIView!

    var stickyHeaderController: StickyHeaderController!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set up sticky header view
        stickyHeaderController = StickyHeaderController(view: myHeaderView, height: 300)
        stickyHeaderController.attach(to: self)
    }

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        super.scrollViewDidScroll(scrollView)

        // Update the layout of the header view
        stickyHeaderController.layoutStickyView()
    }
}
```
