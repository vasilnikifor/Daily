import Foundation

protocol DayNotePresenterProtocol: AnyObject {
    func viewLoaded()
    func closeTapped()
    func removeTapped()
}

final class DayNotePresenter {
    private weak var view: DayNoteViewControllerProtocol?
    
    init(view: DayNoteViewControllerProtocol) {
        self.view = view
    }
}

extension DayNotePresenter: DayNotePresenterProtocol {
    func viewLoaded() {
        let isNoteExist = Bool.random()
        let textText = Bool.random()
            ? "Пахнет осенью. А я люблю российскую осень. Что-то необыкновенно грустное, приветливое и красивое. Взял бы и улетел куда-нибудь вместе с журавлями."
            : "Знаете ли вы украинскую ночь? О, вы не знаете украинской ночи! Всмотритесь в нее: с середины неба глядит месяц; необъятный небесный свод раздался, раздвинулся еще необъятнее; горит и дышит он. Земля вся в серебряном свете; и чудный воздух и прохладно душен, и полон неги, и движет океан благоуханий.\n\nБожественная ночь! Очаровательная ночь! Недвижно, вдохновенно стали леса, полные мрака, и кинули огромную тень от себя. Тихи и спокойны эти пруды; холод и мрак вод их, угрюмо заключён в темно-зеленые стены\n\nДевственные чащи черемух и черешен пугливо протянули корни в ключевой холод и изредка лепечут листьями, будто сердясь и негодуя, когда прекрасный ветреник, ночной ветер, подкравшись мгновенно, целует их. Весь ландшафт спит. А на душе и необъятно и чудно, и толпы серебряных видений стройно возникают в ее глубине. Божественная ночь! Очаровательная ночь!\n\nИ вдруг все ожило: и леса, и пруды, и степи. Сыплется величественный гром украинского соловья; и чудится, что и месяц заслушался его посреди неба. Как очарованное, дремлет на возвышении село. Еще более, еще лучше блестят при месяце толпы хат; еще ослепительнее вырезываются из мрака низкие стены их. Песни умолкли. Все тихо. Благочестивые люди уже спят. Где-где только светятся узенькие окна. Перед порогами иных только хат запоздалая семья совершает свой поздний ужин."
        view?.setupInitialState(
            dateText: Date().dateRepresentation,
            noteText: isNoteExist ? textText : ""
        )
    }
    
    func closeTapped() {
        view?.dismiss()
    }
    
    func removeTapped() {
        view?.dismiss()
    }
}
