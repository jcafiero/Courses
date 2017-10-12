/*
 * 	 Jennifer Cafiero 
 * 
 * 
 *   Example of "Form Template Method" refactoring.
 *
 *   Businesses and individuals are taxed differently
 *   on their purchases.  Individuals pay 3.5% tax on
 *   the full price.  Businesses pay 7% tax but on only
 *   90% of the price.  (Governments make exceptions like
 *   this all the time!)
 *
 *   Below, two subclasses have a method that is similar
 *   but not the same.
 */
class Customer {
	double _price;
	double percent_price;
	double tax_rate;
	
	double totalDue(double percent_price, double tax_rate ) {
        double cost = _price * percent_price;
        double tax = cost * tax_rate; 
        return cost + tax;
    }
	
}
class Individual extends Customer {
    percent_price = 1.0;
    tax_rate = 0.035;
    totalDue(percent_price, tax_rate);
}
class Business extends Customer {
	percent_price = 0.90;
	tax_rate = 0.07;
	totalDue(percent_price, tax_rate);
	
}
