class CreateIngredientEntity {
	final String? name;
	final int unity;
	final double? quantity;
	final double? amount;
	final bool hasMustIngredients;
	final bool isSuccess;

  CreateIngredientEntity({
		this.unity = 0,
		this.hasMustIngredients = false,
		this.isSuccess = false,
		this.name,
		this.quantity,
		this.amount
	});

	CreateIngredientEntity copyWith({
		String? name,
		int? unity,
		double? quantity,
		double? amount,
		bool? hasMustIngredients,
		bool? isSuccess,
	}) => CreateIngredientEntity(
			name: name ?? this.name,
			unity: unity ?? this.unity,
			quantity: quantity ?? this.quantity,
			amount: amount ?? this.amount,
			hasMustIngredients: hasMustIngredients ?? this.hasMustIngredients,
			isSuccess: isSuccess ?? this.isSuccess,
	);
}
