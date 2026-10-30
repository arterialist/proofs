# Build status of the BuildingBlocks library on 31 October 2026

Toolchain Lean 4.34.1, Mathlib `d13f23b7`. Snapshot after the Mathlib port of that night; later commits shrink the failing list. A module counts as built when its `.olean` exists under `.lake/build/lib/lean/BuildingBlocks/`.

- Registered modules in `formalization/BuildingBlocks.lean`: 648
- Built: 550
- Failing in the last sequential pass: 111

The RH chain (`RiemannZetaRatioSurplus`, `RightOfflineContradiction`, `RiemannZetaGrandEquivalence`, `ActualCriticalSignCriterion`) and the growth/excursion modules build. The root module `BuildingBlocks` itself does not build until every registered module does.

## Modules still failing, grouped by the module whose error blocks them

- `SuccessorFeedbackDifference` blocks 41: `ActualCompactHeatEndpoint`, `ActualTerminalPrimeTraceFinite`, `FactorialBinetCenteredGoldbachFinite`, `GoldbachAbsoluteEnergy`, `GoldbachCofactorOddStepFinite`, `GoldbachCofactorWindowFinite`, `GoldbachCumulativeAbel`, `GoldbachCumulativeFinite`, `GoldbachCumulativeStieltjes`, `GoldbachHeatBaseline`, `GoldbachHeatComparison`, `GoldbachHeatConvolution`, `GoldbachHeatIntegral`, `GoldbachHeatLocalEnergy`, `GoldbachHeatQuadratic`, `GoldbachHeatSeries`, `GoldbachPrimeHeatConvolution`, `GoldbachTotalImbalanceFinite`, `IntegerBirthOriginalDriver`, `SuccessorFeedbackAbelClock`, `SuccessorFeedbackAbelLaplace`, `SuccessorFeedbackBoundary`, `SuccessorFeedbackClippedKernel`, `SuccessorFeedbackClock`, `SuccessorFeedbackDecay`, `SuccessorFeedbackDifference`, `SuccessorFeedbackDirichlet`, `SuccessorFeedbackFloorAgeDerivative`, `SuccessorFeedbackFloorBoundary`, `SuccessorFeedbackFloorHolomorphic`, `SuccessorFeedbackFloorKernel`, `SuccessorFeedbackFloorL1`, `SuccessorFeedbackFloorPairing`, `SuccessorFeedbackGamma`, `SuccessorFeedbackIndexCorrection`, `SuccessorFeedbackMellinTail`, `SuccessorFeedbackPowerDifference`, `SuccessorFeedbackRootPrimitive`, `SuccessorFeedbackRootTranslation`, `SuccessorFeedbackSmoothAgeDerivative`, `SuccessorFeedbackSmoothCancellation`
- `SuccessorFeedbackBoundary` blocks 26: `CenteredGoldbachAdjacentTotalsFinite`, `CenteredGoldbachEvenCompensationFinite`, `CenteredGoldbachHeatScaleIncrementFinite`, `CenteredGoldbachHistoryShellFinite`, `CenteredGoldbachPositiveTransferObstruction`, `CenteredGoldbachSuccessorHeatFinite`, `CenteredGoldbachTruncatedHeat`, `EulerResidueDefectFinite`, `FactorialCurvatureGoldbachFinite`, `FactorialHOneFinite`, `FactorialResidueFinite`, `GoldbachEventualCutoffAdjustment`, `GoldbachEventualUpperCutoffAdjustment`, `GoldbachHeatCarryCompensation`, `GoldbachHeatCarryWork`, `GoldbachHeatDerivative`, `GoldbachHeatInitialTrace`, `GoldbachHeatProfileDerivative`, `GoldbachMFunctionCumulantFinite`, `GoldbachOddCumulativeFinite`, `GoldbachOddPowerBoundFinite`, `GoldbachOneSidedHeatTransfer`, `GoldbachOneSidedLowerHeatTransfer`, `GoldbachScrewMinorFinite`, `GoldbachScrewRemainderThresholdFinite`, `GoldbachScrewThreeMinorFinite`
- `ChargeFrozenSource` blocks 25: `ActualPhysicalResidues`, `ActualZeroCircleResidues`, `ChargeFrozenBirthFiniteGram`, `ChargeFrozenBirthGram`, `ChargeFrozenBirthMetric`, `ChargeFrozenBirthWork`, `ChargeFrozenFourier`, `ChargeFrozenFourierNorm`, `ChargeFrozenIntegrability`, `ChargeFrozenLogMoment`, `ChargeFrozenMetric`, `ChargeFrozenPlancherel`, `ChargeFrozenSource`, `ChargeFrozenSpectralBound`, `CompactLocalScatteringSigns`, `CompactPhysicalMellinAnalytic`, `CompactScatteringCoefficients`, `CompactScatteringOperator`, `CompactScatteringPackets`, `CompactScatteringRegularity`, `CompleteArithmeticCorrelation`, `CompletedZetaPoleCorrections`, `FullComplexHistoryMellin`, `GrowingPrimeScatteringBounds`, `PhysicalScatteringCorrelation`
- `ChargeFrozenIntegrability` blocks 6: `ActualPrimeBlockMagnitude`, `ActualPrimeBlockMellinParity`, `ActualPrimeBlockWeilWeightParity`, `ActualScatteringMellinSignBridge`, `AutocorrelationRegularity`, `LogarithmicPrimeWindow`
- `PrimeSeedSquareConvergence` blocks 3: `MemoryChargeCutoff`, `PrimeSeedAllPrimeDerivative`, `PrimeSeedSquareConvergence`
- `FactorialAbelEnvelope` blocks 2: `FactorialAbelClockEnergy`, `FactorialAbelEnvelope`
- `PhysicalContinuousArrivalMass` blocks 2: `PhysicalContinuousArrivalMass`, `PhysicalExteriorArrival`
- `PhysicalThetaJumpHomogeneity` blocks 2: `PhysicalThetaJumpAddition`, `PhysicalThetaJumpHomogeneity`
- `ActualEq22MellinInversion` blocks 1: `ActualEq22OriginalMellin`
- `MemoryChargeEnergy` blocks 1: `MemoryChargeEnergy`
- `PhysicalKillingPositivity` blocks 1: `PhysicalKillingPositivity`
- `PrimeSeedLaplaceExponent` blocks 1: `PrimeSeedLaplaceExponent`
