# Build status of the BuildingBlocks library on 31 October 2026

Toolchain Lean 4.34.1, Mathlib `d13f23b7`. Snapshot after the Mathlib port of that night; later commits shrink the failing list. A module counts as built when its `.olean` exists under `.lake/build/lib/lean/BuildingBlocks/`.

- Registered modules in `formalization/BuildingBlocks.lean`: 646
- Built: 513
- Failing in the last sequential pass: 141

The RH chain (`RiemannZetaRatioSurplus`, `RightOfflineContradiction`, `RiemannZetaGrandEquivalence`, `ActualCriticalSignCriterion`) and the growth/excursion modules build. The root module `BuildingBlocks` itself does not build until every registered module does.

## Modules still failing, grouped by the module whose error blocks them

- `CriticalCoordinatePairing` blocks 52: `ActualPhysicalResidues`, `ChargeDensityEvaluation`, `ChargeFrozenBirthFiniteGram`, `ChargeFrozenBirthGram`, `ChargeFrozenBirthMetric`, `ChargeFrozenBirthWork`, `ChargeFrozenFourier`, `ChargeFrozenFourierNorm`, `ChargeFrozenIntegrability`, `ChargeFrozenLogMoment`, `ChargeFrozenMetric`, `ChargeFrozenPlancherel`, `ChargeFrozenSource`, `ChargeFrozenSpectralBound`, `ChargeOriginalBirth`, `CompactLocalScatteringSigns`, `CompactPhysicalMellinAnalytic`, `CompactScatteringCoefficients`, `CompactScatteringOperator`, `CompactScatteringPackets`, `CompactScatteringRegularity`, `CompleteArithmeticCorrelation`, `FullComplexHistoryMellin`, `GoldbachAbsoluteEnergy`, `GoldbachCofactorOddStepFinite`, `GoldbachCofactorWindowFinite`, `GoldbachHeatBaseline`, `GoldbachHeatComparison`, `GoldbachHeatConvolution`, `GoldbachHeatIntegral`, `GoldbachHeatLocalEnergy`, `GoldbachHeatQuadratic`, `GoldbachHeatSeries`, `GoldbachTotalImbalanceFinite`, `GrowingPrimeScatteringBounds`, `IntegerBirthOriginalDriver`, `PhysicalScatteringCorrelation`, `SuccessorFeedbackAbelClock`, `SuccessorFeedbackAbelLaplace`, `SuccessorFeedbackClippedKernel`, `SuccessorFeedbackFloorAgeDerivative`, `SuccessorFeedbackFloorBoundary`, `SuccessorFeedbackFloorHolomorphic`, `SuccessorFeedbackFloorKernel`, `SuccessorFeedbackFloorL1`, `SuccessorFeedbackFloorPairing`, `SuccessorFeedbackGamma`, `SuccessorFeedbackMellinTail`, `SuccessorFeedbackRootPrimitive`, `SuccessorFeedbackRootTranslation`, `SuccessorFeedbackSmoothAgeDerivative`, `SuccessorFeedbackSmoothCancellation`
- `SuccessorFeedbackSource` blocks 33: `ActualCompactHeatEndpoint`, `ActualTerminalPrimeTraceFinite`, `CenteredGoldbachAdjacentTotalsFinite`, `CenteredGoldbachEvenCompensationFinite`, `CenteredGoldbachHeatScaleIncrementFinite`, `CenteredGoldbachHistoryShellFinite`, `CenteredGoldbachPositiveTransferObstruction`, `CenteredGoldbachSuccessorHeatFinite`, `CenteredGoldbachTruncatedHeat`, `EulerResidueDefectFinite`, `FactorialBinetCenteredGoldbachFinite`, `FactorialCurvatureGoldbachFinite`, `FactorialHOneFinite`, `FactorialResidueFinite`, `GoldbachCumulativeAbel`, `GoldbachCumulativeFinite`, `GoldbachCumulativeStieltjes`, `GoldbachEventualCutoffAdjustment`, `GoldbachEventualUpperCutoffAdjustment`, `GoldbachHeatCarryCompensation`, `GoldbachHeatCarryWork`, `GoldbachHeatDerivative`, `GoldbachHeatInitialTrace`, `GoldbachHeatProfileDerivative`, `GoldbachMFunctionCumulantFinite`, `GoldbachOddCumulativeFinite`, `GoldbachOddPowerBoundFinite`, `GoldbachOneSidedHeatTransfer`, `GoldbachOneSidedLowerHeatTransfer`, `GoldbachPrimeHeatConvolution`, `GoldbachScrewMinorFinite`, `GoldbachScrewRemainderThresholdFinite`, `GoldbachScrewThreeMinorFinite`
- `?` blocks 9: `MemoryChargeCutoff`, `SuccessorFeedbackBoundary`, `SuccessorFeedbackClock`, `SuccessorFeedbackDecay`, `SuccessorFeedbackDifference`, `SuccessorFeedbackDirichlet`, `SuccessorFeedbackIndexCorrection`, `SuccessorFeedbackPowerDifference`, `SuccessorFeedbackSource`
- `ChargeDensityEvaluation` blocks 8: `ActualPrimeBlockMagnitude`, `ActualPrimeBlockMellinParity`, `ActualPrimeBlockWeilWeightParity`, `ActualScatteringMellinSignBridge`, `ActualZeroCircleResidues`, `AutocorrelationRegularity`, `CompletedZetaPoleCorrections`, `LogarithmicPrimeWindow`
- `FactorialBirthLcmEnergy` blocks 6: `FactorialAbelClockEnergy`, `FactorialAbelEnvelope`, `FactorialBirthInteriorBound`, `FactorialBirthLcmEnergy`, `FactorialCompensatedEnvelope`, `FactorialReciprocalPrefix`
- `PhysicalThetaMeasure` blocks 5: `PhysicalExteriorArrival`, `PhysicalKillingPositivity`, `PhysicalThetaJumpEnergy`, `PhysicalThetaJumpHomogeneity`, `PhysicalThetaMeasure`
- `PrimeSeedLawComparison` blocks 5: `PrimeSeedCausalSupport`, `PrimeSeedCutoffConvergence`, `PrimeSeedLaplaceExponent`, `PrimeSeedLawComparison`, `PrimeSeedSquareConvergence`
- `PrimeSeedAllPrimeSquare` blocks 4: `AllPrimeMemoryKernel`, `MemoryChargeEnergy`, `PrimeMemoryChargeDecay`, `PrimeSeedAllPrimeSquare`
- `PhysicalArrivalBoundary` blocks 4: `PhysicalArrivalBoundary`, `PhysicalContinuousArrivalMass`, `PhysicalContinuousSourceConvergence`, `PhysicalPrimeArrivalRegularity`
- `PrimeSeedSemigroup` blocks 4: `PrimeSeedAllPrimeDerivative`, `PrimeSeedDerivativeMeasure`, `PrimeSeedDerivativeVariation`, `PrimeSeedFiniteDerivative`
- `FactorialBinetGoldbachFinite` blocks 2: `FactorialBinetGoldbachFilter`, `FactorialBinetGoldbachFinite`
- `FactorialTerminalReserve` blocks 2: `FactorialTerminalReserve`, `HardClockWeightedLcmClass`
- `ActualEq22PairDilation` blocks 1: `ActualEq22OriginalMellin`
- `ActualPrimeWorkBalance` blocks 1: `ActualPrimeWorkBalance`
- `ActualProperPrimePowerForcing` blocks 1: `ActualProperPrimePowerForcing`
- `IntegerBirthDifferenceL1` blocks 1: `IntegerBirthDifferenceL1`
- `IntegerCarryIntegrationByParts` blocks 1: `IntegerCarryIntegrationByParts`
- `PhysicalThetaJumpEnergy` blocks 1: `PhysicalThetaJumpAddition`
- `ThetaExteriorPrimeIntegrability` blocks 1: `ThetaExteriorPrimeIntegrability`
