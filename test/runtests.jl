push!(LOAD_PATH, "/home/guilhermebodin/Documents/Github/Dualization.jl/src")
using Pkg
Pkg.activate(".") # Just to make sure to use JuMP 0.19.1
using MathOptInterface, Dualization, Test

const MOI  = MathOptInterface
const MOIT = MathOptInterface.Test
const MOIU = MathOptInterface.Utilities
const MOIB = MathOptInterface.Bridges

MOIU.@model(Model,
            (MOI.ZeroOne, MOI.Integer),
            (MOI.EqualTo, MOI.GreaterThan, MOI.LessThan, MOI.Interval,
             MOI.Semicontinuous, MOI.Semiinteger),
            (MOI.Reals, MOI.Zeros, MOI.Nonnegatives, MOI.Nonpositives,
             MOI.SecondOrderCone, MOI.RotatedSecondOrderCone,
             MOI.GeometricMeanCone, MOI.ExponentialCone, MOI.DualExponentialCone,
             MOI.PositiveSemidefiniteConeTriangle, MOI.PositiveSemidefiniteConeSquare,
             MOI.RootDetConeTriangle, MOI.RootDetConeSquare, MOI.LogDetConeTriangle,
             MOI.LogDetConeSquare),
            (MOI.PowerCone, MOI.DualPowerCone, MOI.SOS1, MOI.SOS2),
            (MOI.SingleVariable,),
            (MOI.ScalarAffineFunction, MOI.ScalarQuadraticFunction),
            (MOI.VectorOfVariables,),
            (MOI.VectorAffineFunction, MOI.VectorQuadraticFunction))

cd("test")
# Run tests to travis ci
include("Tests/test_utils.jl")

# Full version of tests, this hsould be all comented to pass travis ci because of dependencies
using JuMP
include("optimize_abstract_models.jl")

# Test Solvers
include("Solvers/linear_problems.jl")
include("Solvers/clp_test.jl")
include("Solvers/glpk_test.jl")


# Test Bigger Problems
include("Problems/LinearPrograms/linear_classifier.jl")