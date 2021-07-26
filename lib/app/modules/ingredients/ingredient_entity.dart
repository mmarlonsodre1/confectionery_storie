class IngredientEntity{
	String? id;
	String? name;
	int? unity;
	double? quantity;
	double? amount;
	bool? hasMustIngredients;
	List<IngredientEntity>? ingredients;

	IngredientEntity(this.name, this.unity, this.quantity, this.amount,
      this.hasMustIngredients, this.ingredients);
}