class IngredientEntity{
	String? name;
	int? unity;
	double? quantity;
	double? amount;
	bool? hasMustIngredients;
	List<IngredientEntity>? ingredients;

	IngredientEntity(this.name, this.unity, this.quantity, this.amount,
      this.hasMustIngredients, this.ingredients);

	IngredientEntity empty() => IngredientEntity(null, null, null, null, null, null);

}