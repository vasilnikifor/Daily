import UIKit

protocol ImageRecordDelegate {
    func imageRecordDidChange()
}

struct ImageRecordViewModel {
    let date: Date
    let imageRecord: ImageRecord
}

class ImageRceordViewController: UIViewController {
    @IBOutlet private weak var timeLabel: SmallSecondaryTextLabel!
    @IBOutlet private weak var imageView: UIImageView!
    
    private var date: Date = Date()
    private var imageRecord: ImageRecord?
    private var delegate: ImageRecordDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "trash") ?? UIImage(),
            style: .plain,
            target: self,
            action: #selector(removeImage)
        )
    }
    
    func configure(_ viewModel: ImageRecordViewModel, delegate: ImageRecordDelegate) {
        self.delegate = delegate
        
        date = viewModel.date
        imageRecord = viewModel.imageRecord
        
        if let imageRecord = imageRecord, let time = imageRecord.time, let imageData = imageRecord.imageData {
            timeLabel.text = time.timeRepresentation
            imageView.image = UIImage(data: imageData)
        }
    }
}

// MARK: - Private methods
extension ImageRceordViewController {
    @objc
    private func removeImage() {

    }
}
