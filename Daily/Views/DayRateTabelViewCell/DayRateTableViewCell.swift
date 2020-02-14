import UIKit

struct DayRateTableVievCellViewModel {
    let dayRate: DayRate
    let isSelected: Bool
}

class DayRateTableViewCell: UITableViewCell {
    @IBOutlet weak var moodImageView: UIImageView!
    @IBOutlet weak var selectedImageView: UIImageView!
    @IBOutlet weak var moodNameLabel: MediumPrimaryTextLabel!
    
    func configure(for viewModel: DayRateTableVievCellViewModel) {
        moodImageView.image = Theme.getRateImage(viewModel.dayRate)
        moodImageView.tintImage(to: Theme.getRateColor(viewModel.dayRate))
                
        moodNameLabel.text = Theme.getRateName(viewModel.dayRate)
        
        selectedImageView.isHidden = !viewModel.isSelected
    }
}
