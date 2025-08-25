//
//  SearchViewModelTests.swift
//  ChallengeMELI_Nehuen_RothTests
//
//  Created by nehuen roth on 24/08/2025.
//

import XCTest
@testable import ChallengeMELI_Nehuen_Roth

final class SearchViewModelTests_Nehuen_RothTests: XCTestCase {

    // MARK: - Unit Tests con Mock
    @MainActor
    func testSearch_success_setsReady() async {
        let sample = Article.skeleton(id: 1)
        let vm = await makeSearchViewModel(with: .success([sample]))
        
        if case let .ready(items) = vm.searchState {
            XCTAssertEqual(items.first?.title, "Skeleton")
        } else {
            XCTFail("Se esperaba: .ready")
        }
    }

    @MainActor
    func testSearch_failure_setsError() async {
        let vm = await makeSearchViewModel(with: .failure)
        
        if case .error(error: _,
                       errorString: let message,
                       retry: _) = vm.searchState {
            XCTAssertTrue(vm.searchData.isEmpty)
            XCTAssertFalse(message.isEmpty)
        } else {
            XCTFail("Se esperaba: .error")
        }
    }

    @MainActor
    func testSearch_empty_setsEmptyState() async {
        let vm = await makeSearchViewModel(with: .success([]))
        
        if case .error(error: GetErrors.noData,
                       errorString: _,
                       retry: _) = vm.searchState {
            XCTAssertTrue(vm.searchData.isEmpty)
        } else {
            XCTFail("Se esperaba: .error por datos vacíos")
        }
    }
    
    // MARK: - Integration Test con API real
    @MainActor
    func testSearch_integrationWithRealAPI() async {
       let service = SearchServiceManager()
       let vm = SearchViewModel(searchServiceManager: service)
       
       await vm.getItemsBySearchText(searchText: "SpaceX")
       
       switch vm.searchState {
       case .ready(let articles):
           XCTAssertFalse(articles.isEmpty, "Se esperaba información de la API")
           XCTAssertNotNil(articles.first?.title)
       case .error(let error, let message, _):
           XCTFail("Se esperaba .ready pero llegó error: \(error) - \(message)")
       default:
           XCTFail("Estado inesperado: \(vm.searchState)")
       }
    }
    
    // MARK: - History / searchedDataSave Tests
    @MainActor
    func testSearch_addsToHistory() async {
        let vm = await makeSearchViewModel(with: .success([Article.skeleton(id: 1)]))
        
        XCTAssertTrue(vm.searchedDataSave.isEmpty)
        
        vm.setSearchString(text: "SpaceX")
        await vm.search()
        
        XCTAssertEqual(vm.searchedDataSave.count, 1)
        XCTAssertEqual(vm.searchedDataSave.first, "SpaceX")
        
        vm.setSearchString(text: "SpaceX")
        await vm.search()
        
        XCTAssertEqual(vm.searchedDataSave.count, 1)
        XCTAssertEqual(vm.searchedDataSave.first, "SpaceX")
        
        vm.setSearchString(text: "NASA")
        await vm.search()
        
        XCTAssertEqual(vm.searchedDataSave.count, 2)
        XCTAssertEqual(vm.searchedDataSave.first, "NASA")
        XCTAssertEqual(vm.searchedDataSave.last, "SpaceX")
    }

    // MARK: - Helpers
    @MainActor
    private func makeSearchViewModel(with scenario: MockSearchServiceManager.Scenario) async -> SearchViewModel {
        let mock = MockSearchServiceManager()
        mock.scenario = scenario
        let vm = SearchViewModel(searchServiceManager: mock)
        await vm.getItemsBySearchText(searchText: "test")
        try? await Task.sleep(nanoseconds: 200_000_000)
        return vm
    }
}

