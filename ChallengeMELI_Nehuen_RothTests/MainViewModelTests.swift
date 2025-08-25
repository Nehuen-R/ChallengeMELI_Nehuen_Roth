//
//  ChallengeMELI_Nehuen_RothTests.swift
//  ChallengeMELI_Nehuen_RothTests
//
//  Created by nehuen roth on 20/08/2025.
//

import XCTest
@testable import ChallengeMELI_Nehuen_Roth

final class ChallengeMELI_Nehuen_RothTests: XCTestCase {

    // MARK: - Unit Tests con Mock
    @MainActor
    func testLoadArticles_success_setsReady() async {
        let sample = Article.skeleton(id: 1)
        let vm = await makeViewModel(with: .success([sample]))
        if case let .ready(items) = vm.mainState {
            XCTAssertEqual(items.first?.title, "Skeleton")
        } else {
            XCTFail("Se esperaba: .ready")
        }
    }

    @MainActor
    func testLoadArticles_failure_setsError() async {
        let vm = await makeViewModel(with: .failure)
        if case .error(error: _,
                       errorString: let message,
                       retry: _) = vm.mainState {
            XCTAssertTrue(vm.articles.isEmpty)
            XCTAssertFalse(message.isEmpty)
        } else {
            XCTFail("Se esperaba: .error")
        }
    }

    @MainActor
    func testLoadArticles_empty_setsEmptyState() async {
        let vm = await makeViewModel(with: .success([]))
        if case .error(error: GetErrors.noData,
                       errorString: "No se encontro información",
                       retry: _) = vm.mainState {
            XCTAssertTrue(vm.articles.isEmpty)
        } else {
            XCTFail("Se esperaba: .error")
        }
    }
    
    // MARK: - Integration Test con API real
    @MainActor
    func testLoadArticles_integrationWithRealAPI() async {
        let service = MainServiceManager()
        let vm = MainViewModel(mainServiceManager: service)

        await vm.getArticles()

        switch vm.mainState {
        case .ready(let articles):
            XCTAssertFalse(articles.isEmpty, "Se esperaba información de la API")
            XCTAssertNotNil(articles.first?.title)
        case .error(let error, let message, _):
            XCTFail("Se esperaba .ready pero llego error: \(error) - \(message)")
        default:
            XCTFail("Estado inesperado: \(vm.mainState)")
        }
    }
    
    // MARK: - Helpers
    @MainActor
    private func makeViewModel(with scenario: MockMainServiceManager.Scenario) async -> MainViewModel {
        let mock = MockMainServiceManager()
        mock.scenario = scenario
        let vm = MainViewModel(mainServiceManager: mock)
        await vm.getArticles()
        try? await Task.sleep(nanoseconds: 200_000_000)
        return vm
    }
}
