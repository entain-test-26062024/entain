//
//  NextToGoViewModelTests.swift
//  EntainTests
//
//  Created by BS Entain on 25/6/2024.
//

import XCTest
@testable import Entain

class NextToGoViewModelTests: XCTestCase {
    @MainActor func viewModel(withResponseType responseType: MockedResponseType) -> NextToGoViewModel {
        let repository = MockNextToGoRepository(responseType: responseType)
        return NextToGoViewModel(repository: repository)
    }

    func testOnAppearLoadsData() async {
        let viewModel = await viewModel(withResponseType: .data(count: 3))
        await viewModel.onAppear()
        let value = await viewModel.races.isNotEmpty
        XCTAssertTrue(value)
    }

    func testRefreshResetsData() async {
        let viewModel = await viewModel(withResponseType: .data(count: 3))
        await viewModel.refresh()
        let value = await viewModel.races.isNotEmpty
        XCTAssertTrue(value)
    }

    func testFetchRacesOutdatedResults() async {
        let viewModel = await viewModel(withResponseType: .data(count: 3))
        await viewModel.fetchRaces()
        let value = await viewModel.races
        XCTAssertEqual(value.count, 2) // Should be 2, because we've got an expired value in the mocks and two future values
    }

    func testFetchRacesSetsEmptyState() async {
        let viewModel = await viewModel(withResponseType: .empty)
        await viewModel.fetchRaces()
        let value = await viewModel.isEmpty
        XCTAssertTrue(value)
    }

    func testFetchRacesSetsEmptyStateOnError() async {
        let viewModel = await viewModel(withResponseType: .error)
        await viewModel.fetchRaces()
        let value = await viewModel.isEmpty
        XCTAssertTrue(value)
    }

    func testFetchRacesSortsResults() async {
        let viewModel = await viewModel(withResponseType: .data(count: 3))
        await viewModel.fetchRaces()
        let races = await viewModel.races
        let value = races.first
        XCTAssertEqual(value?.id, "SOME_UPCOMING_ID") // This is inserted last in the mocks, however should be shuffled to the first place as it is the closest to the current date
    }

    func testFetchRacesLimitsToFiveResults() async {
        let viewModel = await viewModel(withResponseType: .data(count: 10))
        await viewModel.fetchRaces()
        let races = await viewModel.races
        let value = races.count
        XCTAssertEqual(value, 5)
    }

    func testDidSelectFilter() async {
        let viewModel = await viewModel(withResponseType: .data(count: 3))
        await viewModel.didSelectFilter(.greyhound)
        let value = await viewModel.selectedFilter
        XCTAssertEqual(RaceFilter.greyhound, value)
    }

    func testDidClearFilters() async {
        let viewModel = await viewModel(withResponseType: .data(count: 3))
        await viewModel.didSelectFilter(.greyhound)
        await viewModel.didClearFilters()
        let value = await viewModel.selectedFilter
        XCTAssertNil(value)
    }

    func testDidReceiveAlarmRemovesValue() async {
        let viewModel = await viewModel(withResponseType: .data(count: 3))
        await viewModel.fetchRaces()
        let races = await viewModel.races
        guard let alarmRace = races.first else { XCTAssert(false, "No data available to assert against, check your test case or your view model logic"); return }
        await viewModel.didReceiveAlarmFor(alarmRace)
        let value = await viewModel.races.contains(alarmRace)
        XCTAssertFalse(value)
    }
}
