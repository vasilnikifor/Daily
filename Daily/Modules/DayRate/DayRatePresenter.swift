import Foundation

protocol DayRatePresenterProtocol: AnyObject {
    func viewLoaded()
    func closeTapped()
    func removeTapped()
}

final class DayRatePresenter {
    private weak var view: DayRateViewControllerProtocol?
    private var dayService: DayServiceProtocol
    private weak var calendarDelegate: CalendarDelegate?
    private var date: Date
    private var selectedRate: DayRate?
    
    init(view: DayRateViewControllerProtocol,
         dayService: DayServiceProtocol,
         inputModel: DayRateInputModel) {
        self.view = view
        self.dayService = dayService
        calendarDelegate = inputModel.delegate
        date = inputModel.date
        selectedRate = inputModel.selectedRate
    }
    
    private func update(selectedRate: DayRate?) {
        dayService.rateDay(of: date, rate: selectedRate)
        calendarDelegate?.update()
        view?.dismiss()
    }
}

extension DayRatePresenter: DayRatePresenterProtocol {
    func viewLoaded() {
        view?.setupInitialState(dateText: date.dateRepresentation)
        
        view?.update(
            badRateViewModel: DayRateViewModel(
                image: Theme.badRateImage,
                tintColor: Theme.badRateColor,
                isSelected: selectedRate == .bad,
                action: { [weak self] in self?.update(selectedRate: .bad) }
            ),
            averageRateViewModel: DayRateViewModel(
                image: Theme.averageRateImage,
                tintColor: Theme.averageRateColor,
                isSelected: selectedRate == .average,
                action: { [weak self] in self?.update(selectedRate: .average) }
            ),
            goodRateViewModel: DayRateViewModel(
                image: Theme.goodRateImage,
                tintColor: Theme.goodRateColor,
                isSelected: selectedRate == .good,
                action: { [weak self] in self?.update(selectedRate: .good) }
            )
        )
    }
    
    func closeTapped() {
        view?.dismiss()
    }
    
    func removeTapped() {
        update(selectedRate: nil)
    }
}
