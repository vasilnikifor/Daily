import UIKit

protocol DayRecordsPresenterProtocol {
    func viewLoaded()
    func rateDayTapped()
    func addNoteTapped()
}

final class DayRecordsPresenter {
    private weak var view: DayRecordsViewControllerProtocol?
    private var dayService: DayServiceProtocol
    private weak var delegate: CalendarDelegate?
    private let date: Date
    private var day: Day?
    
    init(view: DayRecordsViewControllerProtocol,
         dayService: DayServiceProtocol,
         inputModel: DayRecordsInputModel) {
        self.view = view
        self.dayService = dayService
        delegate = inputModel.delegate
        date = inputModel.date
        day = inputModel.day
    }
    
    private func openNote(_ noteRecord: NoteRecord?) {
        view?.present(
            DayNoteAssembler.assemble(
                DayNoteInputModel(
                    date: date,
                    note: noteRecord,
                    delegate: self
                )
            )
        )
    }
}

extension DayRecordsPresenter: DayRecordsPresenterProtocol {
    func viewLoaded() {
        view?.setupInitialState(dateText: date.dateRepresentation)
        update()
    }
    
    func rateDayTapped() {
        view?.present(
            DayRateAssembler.assemble(
                DayRateInputModel(
                    date: date,
                    selectedRate: day?.rate,
                    delegate: self
                )
            )
        )
    }
    
    func addNoteTapped() {
        openNote(nil)
    }
}


extension DayRecordsPresenter: CalendarDelegate {
    func update() {
        day = dayService.getDay(date: date)
        
        let rateImage: UIImage
        switch day?.rate {
        case .none:
            rateImage = Theme.rateDayImage
        case .bad:
            rateImage = Theme.badRateImage
        case .average:
            rateImage = Theme.averageRateImage
        case .good:
            rateImage = Theme.goodRateImage
        }
        
        let dataSource:  [DayRecordsDataSource]
        if let records = day?.records {
            dataSource = records
                .sorted { record1, record2 in
                    guard let record1 = record1 as? Record,
                          let record1Time = record1.time,
                          let record2 = record2 as? Record,
                          let record2Time = record2.time else { return false }
                    return record1Time < record2Time
                }
                .compactMap { record in
                    if let noteRecord = record as? NoteRecord {
                        return .note(
                            viewModel: NoteRecordCellViewModel(
                                text: noteRecord.text ?? "",
                                time: (noteRecord.time ?? Date()).timeRepresentation,
                                action: { [weak self, weak noteRecord] in self?.openNote(noteRecord)}
                            )
                        )
                    } else {
                        return nil
                    }
                }
        } else {
            dataSource = []
        }
        
        view?.update(rateImage: rateImage, dataSource: dataSource)
        delegate?.update()
    }
}
