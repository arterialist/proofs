# Build status of the BuildingBlocks library on 31 October 2026

Toolchain Lean 4.34.1, Mathlib `d13f23b7`. Snapshot after the Mathlib port of that night; later commits shrink the failing list. A module counts as built when its `.olean` exists under `.lake/build/lib/lean/BuildingBlocks/`.

- Registered modules in `formalization/BuildingBlocks.lean`: 648
- Built: 582
- Failing in the last sequential pass: 83

The RH chain (`RiemannZetaRatioSurplus`, `RightOfflineContradiction`, `RiemannZetaGrandEquivalence`, `ActualCriticalSignCriterion`) and the growth/excursion modules build. The root module `BuildingBlocks` itself does not build until every registered module does.

## Modules still failing, grouped by the module whose error blocks them

- `GoldbachHeatSeries` blocks 28: `CenteredGoldbachAdjacentTotalsFinite`, `CenteredGoldbachEvenCompensationFinite`, `CenteredGoldbachHeatScaleIncrementFinite`, `CenteredGoldbachHistoryShellFinite`, `CenteredGoldbachPositiveTransferObstruction`, `CenteredGoldbachSuccessorHeatFinite`, `CenteredGoldbachTruncatedHeat`, `EulerResidueDefectFinite`, `FactorialCurvatureGoldbachFinite`, `FactorialHOneFinite`, `FactorialResidueFinite`, `GoldbachCumulativeAbel`, `GoldbachCumulativeStieltjes`, `GoldbachEventualCutoffAdjustment`, `GoldbachEventualUpperCutoffAdjustment`, `GoldbachHeatCarryCompensation`, `GoldbachHeatCarryWork`, `GoldbachHeatDerivative`, `GoldbachHeatInitialTrace`, `GoldbachHeatProfileDerivative`, `GoldbachMFunctionCumulantFinite`, `GoldbachOddCumulativeFinite`, `GoldbachOddPowerBoundFinite`, `GoldbachOneSidedHeatTransfer`, `GoldbachOneSidedLowerHeatTransfer`, `GoldbachScrewMinorFinite`, `GoldbachScrewRemainderThresholdFinite`, `GoldbachScrewThreeMinorFinite`
- `SuccessorFeedbackClock` blocks 23: `GoldbachCofactorOddStepFinite`, `GoldbachCofactorWindowFinite`, `GoldbachHeatBaseline`, `GoldbachHeatComparison`, `GoldbachHeatLocalEnergy`, `GoldbachHeatQuadratic`, `GoldbachHeatSeries`, `SuccessorFeedbackAbelClock`, `SuccessorFeedbackAbelLaplace`, `SuccessorFeedbackClippedKernel`, `SuccessorFeedbackClock`, `SuccessorFeedbackFloorAgeDerivative`, `SuccessorFeedbackFloorBoundary`, `SuccessorFeedbackFloorHolomorphic`, `SuccessorFeedbackFloorKernel`, `SuccessorFeedbackFloorL1`, `SuccessorFeedbackFloorPairing`, `SuccessorFeedbackGamma`, `SuccessorFeedbackMellinTail`, `SuccessorFeedbackRootPrimitive`, `SuccessorFeedbackRootTranslation`, `SuccessorFeedbackSmoothAgeDerivative`, `SuccessorFeedbackSmoothCancellation`
- `CompactLocalScatteringSigns` blocks 9: `CompactLocalScatteringSigns`, `CompactScatteringCoefficients`, `CompactScatteringOperator`, `CompactScatteringPackets`, `CompactScatteringRegularity`, `CompleteArithmeticCorrelation`, `FullComplexHistoryMellin`, `GrowingPrimeScatteringBounds`, `PhysicalScatteringCorrelation`
- `GoldbachHeatQuadratic` blocks 5: `ActualCompactHeatEndpoint`, `ActualTerminalPrimeTraceFinite`, `FactorialBinetCenteredGoldbachFinite`, `GoldbachCumulativeFinite`, `GoldbachPrimeHeatConvolution`
- `CompactScatteringOperator` blocks 5: `ActualZeroCircleResidues`, `AutocorrelationRegularity`, `CompactPhysicalMellinAnalytic`, `CompletedZetaPoleCorrections`, `LogarithmicPrimeWindow`
- `CompactScatteringRegularity` blocks 4: `ActualPrimeBlockMagnitude`, `ActualPrimeBlockMellinParity`, `ActualPrimeBlockWeilWeightParity`, `ActualScatteringMellinSignBridge`
- `SuccessorFeedbackGamma` blocks 4: `GoldbachAbsoluteEnergy`, `GoldbachHeatConvolution`, `GoldbachHeatIntegral`, `GoldbachTotalImbalanceFinite`
- `ChargeFrozenBirthGram` blocks 2: `ChargeFrozenBirthFiniteGram`, `ChargeFrozenBirthGram`
- `ChargeFrozenFourierNorm` blocks 2: `ChargeFrozenFourierNorm`, `ChargeFrozenPlancherel`
- `GrowingPrimeScatteringBounds` blocks 1: `ActualPhysicalResidues`
