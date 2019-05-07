"""
    dualize(model::MOI.ModelLike, ::Type{T}) where T

Dualize the model
"""
function dualize(model::MOI.ModelLike, ::Type{T}) where T
    # Query all constraint types of the model
    constr_types = MOI.get(model, MOI.ListOfConstraints())
    supported_constraints(constr_types) # Throws an error if constraint cannot be dualized
    
    # Query the objective function type of the model
    obj_func_type = MOI.get(model, MOI.ObjectiveFunctionType())
    supported_objective(obj_func_type) # Throws an error if objective function cannot be dualized
    
    # Crates an empty model that supports the duals of the existing constraints
    dualmodel = emptydualmodel(model)
    
    # Fill the dual model with the dual constraint
    for (F, S) in constr_types
        # Query constraints of type (F,S)
        constrs_F_S = MOI.get(model, MOI.ListOfConstraintIndices{F, S}())
        # Add the dualized constraint to the model
        for constr in constrs_F_S
            add_dual(dualmodel, constr)
        end
    end

    # Fill the dual model with the dual objective

    return dualmodel
end

"""
"""
function emptydualmodel(model::MOI.ModelLike, ::Type{T}) where T
    
    return dualmodel
end