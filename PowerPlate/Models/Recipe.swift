import Foundation

enum Category: String, Codable  {
    case breakfast, lunch, dinner, snack
    
}

struct Recipe: Identifiable, Codable {
    var id = UUID()
    let name: String
    let category: Category
    let description: String
    let imageName: String
    let ingredients: [String]
    let instructions: [String]
    let preparationTime: Int
    let calories: Int
    let protein: Int
    let carbs: Int
    let fat: Int
    var isFavorite = false
}

extension Recipe {
    static let sampleRecipes: [Recipe] = [
        Recipe(
            name: "Energizing Oatmeal with Berries and Nuts",
            category: .breakfast,
            description: "A classic athlete's breakfast to power your morning workout or start your day with sustained energy.",
            imageName: "dish1",
            ingredients: [
            "1/2 Cup Rolled Oats",
            "1 Cup Water or Milk",
            "1/2 Cup Mixed Berries",
            "1 tbsp Chopped Nuts (e.g., Walnuts, Almonds)",
            "1 tsp Honey or Maple Syrup (optional)",
            "Pinch of Cinnamon"
    ],
            instructions: [
            "Combine oats and water or milk in a pot.",
            "Bring to a boil, then reduce heat and simmer for 5-10 minutes, stirring occasionally, until desired consistency.",
            "Pour oatmeal into a bowl.",
            "Top with mixed berries, chopped nuts, cinnamon, and sweetener if desired.",
            "Serve warm."
    ],
            preparationTime: 5,
            calories: 350,
            protein: 10,
            carbs: 50,
            fat: 12
        ),
        Recipe(
            name: "Scrambled Eggs with Spinach and Whole Wheat Toast",
            category: .breakfast,
            description: "A quick and protein-rich breakfast or post-workout meal for muscle recovery.",
            imageName: "dish2",
            ingredients: [
            "2 Large Eggs",
            "1 tbsp Milk (optional)",
            "1 Cup Fresh Spinach",
            "1 tsp Olive Oil or Butter",
            "1 Slice Whole Wheat Toast",
            "Salt and Pepper to taste"
    ],
            instructions: [
            "Whisk eggs and milk (if using) in a bowl with salt and pepper.",
            "Heat olive oil or butter in a non-stick pan over medium heat.",
            "Add spinach and cook until wilted (about 1-2 minutes).",
            "Pour in egg mixture. Stir gently with a spatula until eggs are cooked to your liking.",
            "Serve scrambled eggs with a slice of whole wheat toast."
    ],
            preparationTime: 5,
            calories: 300,
            protein: 18,
            carbs: 10,
            fat: 20
        ),
        Recipe(
            name: "Grilled Chicken Salad with Avocado",
            category: .lunch,
            description: "A light yet satisfying lunch packed with protein and healthy fats for balanced energy.",
            imageName: "dish3",
            ingredients: [
            "150 g Chicken Breast",
            "2 Cups Mixed Greens",
            "1/2 Avocado, sliced",
            "1/4 Cup Cherry Tomatoes, halved",
            "1/4 Cucumber, sliced",
            "1 tbsp Olive Oil",
            "1 tbsp Lemon Juice",
            "Salt and Pepper to taste"
    ],
            instructions: [
            "Season chicken breast with salt and pepper.",
            "Grill or pan-fry chicken for 7-8 minutes per side, or until cooked through.",
            "Let chicken rest for a few minutes, then slice.",
            "In a bowl, combine mixed greens, cherry tomatoes, and cucumber.",
            "Arrange sliced chicken and avocado over the salad.",
            "Whisk olive oil and lemon juice together for dressing. Drizzle over the salad.",
            "Serve immediately."
    ],
            preparationTime: 10,
            calories: 450,
            protein: 40,
            carbs: 15,
            fat: 25
        ),
        Recipe(
            name: "Lentil Soup",
            category: .lunch,
            description: "A warm and hearty soup, great for sustained energy and a good source of plant-based protein and fiber.",
            imageName: "dish4",
            ingredients: [
            "1 tbsp Olive Oil",
            "1 Onion, chopped",
            "2 Carrots, chopped",
            "2 Celery Stalks, chopped",
            "2 Cloves Garlic, minced",
            "1 Cup Brown or Green Lentils, rinsed",
            "4 Cups Vegetable or Chicken Broth",
            "1 Can (400g) Crushed Tomatoes",
            "1 tsp Dried Thyme",
            "Salt and Pepper to taste"
    ],
            instructions: [
            "Heat olive oil in a large pot over medium heat.",
            "Add onion, carrots, and celery. Cook until softened, about 8-10 minutes.",
            "Stir in garlic and thyme, cook for 1 minute.",
            "Add rinsed lentils, broth, and crushed tomatoes.",
            "Bring to a boil, then reduce heat, cover, and simmer for 20-25 minutes, or until lentils are tender.",
            "Season with salt and pepper.",
            "Serve hot."
    ],
            preparationTime: 10,
            calories: 300,
            protein: 20,
            carbs: 40,
            fat: 8
        ),
        Recipe(
            name: "Baked Salmon with Roasted Sweet Potato and Broccoli",
            category: .dinner,
            description: "An excellent dinner for recovery, providing protein, healthy fats, and complex carbohydrates.",
            imageName: "dish5",
            ingredients: [
            "150 g Salmon Fillet",
            "1 Medium Sweet Potato, cubed",
            "1 Cup Broccoli Florets",
            "1 tbsp Olive Oil",
            "1 Clove Garlic, minced",
            "Salt, Pepper, and Paprika to taste"
    ],
            instructions: [
            "Preheat oven to 200℃.",
            "On a baking sheet, toss sweet potato and broccoli with olive oil, garlic, salt, pepper, and paprika.",
            "Spread vegetables in a single layer.",
            "Place salmon fillet on the same baking sheet, season with salt and pepper.",
            "Bake for 20-25 minutes, or until salmon is cooked through and vegetables are tender.",
            "Serve together."
    ],
            preparationTime: 15,
            calories: 550,
            protein: 35,
            carbs: 40,
            fat: 30
        ),
        Recipe(
            name: "Quick Protein Smoothie",
            category: .snack,
            description: "A fast and easy way to get protein and carbs post-workout or as a quick snack.",
            imageName: "dish6",
            ingredients: [
            "1 Scoop Protein Powder",
            "1 Banana",
            "1 Cup Milk or Almond Milk",
            "1 tbsp Peanut Butter (optional)",
            "1/2 Cup Ice Cubes (optional)"
    ],
            instructions: [
            "Combine all ingredients in a blender.",
            "Blend until smooth.",
            "Pour into a glass and serve immediately."
    ],
            preparationTime: 5,
            calories: 350,
            protein: 30,
            carbs: 30,
            fat: 15
        ),
        Recipe(
            name: "Chicken and Vegetable Stir-fry with Brown Rice",
            category: .dinner,
            description: "A balanced and flavorful meal, perfect for dinner, providing protein and a variety of micronutrients.",
            imageName: "dish7",
            ingredients: [
            "200 g Chicken Breast, sliced",
            "2 Cups Mixed Vegetables (e.g., Broccoli, Bell Peppers, Carrots, Snap Peas)",
            "2 Cloves Garlic, minced",
            "1 tbsp Ginger, minced",
            "2 tbsp Soy Sauce",
            "1 tbsp Honey",
            "1 tsp Sesame Oil",
            "1 tbsp Olive Oil",
            "1 Cup Cooked Brown Rice"
    ],
            instructions: [
            "Cook brown rice according to package instructions.",
            "In a small bowl, whisk together soy sauce, honey, and sesame oil.",
            "Heat olive oil in a large pan or wok over high heat.",
            "Add sliced chicken and stir-fry until cooked through.",
            "Add garlic and ginger, cook for 1 minute until fragrant.",
            "Add mixed vegetables and stir-fry for 5-7 minutes until tender-crisp.",
            "Pour sauce over chicken and vegetables, stir to coat. Cook for 1-2 minutes more.",
            "Serve hot over brown rice."
    ],
            preparationTime: 15,
            calories: 500,
            protein: 40,
            carbs: 55,
            fat: 15
        ),
        Recipe(
            name: "Greek Yogurt with Honey and Granola",
            category: .snack,
            description: "A simple and quick snack or breakfast, providing protein from yogurt and carbs from granola.",
            imageName: "dish8",
            ingredients: [
            "1 Cup Plain Greek Yogurt",
            "2 tbsp Granola",
            "1 tbsp Honey"
    ],
            instructions: [
            "Spoon Greek yogurt into a bowl.",
            "Top with granola.",
            "Drizzle with honey.",
            "Serve immediately."
    ],
            preparationTime: 2,
            calories: 250,
            protein: 20,
            carbs: 25,
            fat: 8
        ),
        Recipe(
            name: "Tuna and Avocado Salad",
            category: .lunch,
            description: "A quick and easy high-protein meal, great for lunch or post-workout.",
            imageName: "dish9",
            ingredients: [
            "1 Can (150g) Tuna, drained",
            "1/2 Avocado, mashed",
            "1 tbsp Mayonnaise or Greek Yogurt",
            "1/4 Celery Stalk, finely chopped",
            "Salt and Pepper to taste",
            "Optional: Lettuce leaves, Whole wheat crackers"
    ],
            instructions: [
            "In a bowl, combine drained tuna and mashed avocado.",
            "Stir in mayonnaise or Greek yogurt and chopped celery.",
            "Season with salt and pepper.",
            "Mix until well combined.",
            "Serve on lettuce leaves or with whole wheat crackers."
    ],
            preparationTime: 10,
            calories: 380,
            protein: 30,
            carbs: 8,
            fat: 28
        ),
        Recipe(
            name: "Sweet Potato and Black Bean Burrito Bowl (Vegetarian)",
            category: .dinner,
            description: "A flavorful and filling vegetarian meal, packed with complex carbs and plant-based protein.",
            imageName: "dish10",
            ingredients: [
            "1 Medium Sweet Potato, cubed",
            "1 tbsp Olive Oil",
            "1 tsp Cumin",
            "1 tsp Chili Powder",
            "Salt and Pepper to taste",
            "1 Can (400g) Black Beans, rinsed and drained",
            "1/2 Cup Corn (canned or frozen)",
            "1/4 Red Onion, diced",
            "1/2 Avocado, sliced (optional)",
            "Cooked Brown Rice (for serving)"
    ],
            instructions: [
            "Toss sweet potato cubes with olive oil, cumin, chili powder, salt, and pepper.",
            "Roast in preheated oven (200℃) for 20-25 minutes until tender.",
            "Warm black beans and corn in a small pot.",
            "Assemble bowls: Start with brown rice, top with roasted sweet potato, warmed beans/corn, diced red onion, and avocado slices if using.",
            "Serve warm."
    ],
            preparationTime: 15,
            calories: 480,
            protein: 15,
            carbs: 65,
            fat: 18
        ),
        Recipe(
            name: "Berry and Banana Smoothie Bowl",
            category: .snack,
            description: "A refreshing and nutrient-dense bowl, great for breakfast or a substantial snack.",
            imageName: "dish11",
            ingredients: [
            "1 Frozen Banana",
            "1 Cup Frozen Mixed Berries",
            "1/2 Cup Milk or Yogurt",
            "1 tbsp Chia Seeds",
            "Toppings: Fresh Berries, Sliced Banana, Granola, Shredded Coconut"
    ],
            instructions: [
            "Combine frozen banana, frozen berries, milk or yogurt, and chia seeds in a blender.",
            "Blend until very thick and smooth. Add a little more liquid if needed.",
            "Spoon mixture into a bowl.",
            "Arrange your desired toppings artistically over the top.",
            "Serve immediately."
    ],
            preparationTime: 10,
            calories: 300,
            protein: 8,
            carbs: 45,
            fat: 10
        ),
        Recipe(
            name: "Hard-Boiled Eggs (Quick Protein Snack)",
            category: .snack,
            description: "Simple, portable, and packed with high-quality protein.",
            imageName: "dish12",
            ingredients: [
            "6 Large Eggs",
            "Water",
            "Ice"
    ],
            instructions: [
            "Place eggs in a single layer in a pot.",
            "Cover with cold water by about an inch.",
            "Bring water to a rolling boil over high heat.",
            "Once boiling, immediately remove pot from heat, cover, and let stand for 10-12 minutes for large eggs.",
            "Prepare an ice bath (a bowl with ice and water).",
            "Transfer eggs to the ice bath with a slotted spoon and let cool for at least 5 minutes.",
            "Peel and serve, or store in the refrigerator."
    ],
            preparationTime: 2,
            calories: 70,
            protein: 6,
            carbs: 1,
            fat: 5
        ),
        Recipe(
            name: "Quinoa Salad with Cucumber and Chickpeas (Vegan)",
            category: .lunch,
            description: "A refreshing and light vegan salad, excellent source of protein and complex carbohydrates.",
            imageName: "dish13",
            ingredients: [
            "1 Cup Quinoa, rinsed",
            "2 Cups Vegetable Broth or Water",
            "1 Cup Cucumber, diced",
            "1 Cup Cherry Tomatoes, halved",
            "1 Can (400g) Chickpeas, rinsed and drained",
            "1/4 Red Onion, finely diced",
            "2 tbsp Fresh Parsley, chopped",
            "2 tbsp Lemon Juice",
            "1 tbsp Olive Oil",
            "Salt and Pepper to taste"
    ],
            instructions: [
            "Combine rinsed quinoa and broth or water in a pot. Bring to a boil.",
            "Reduce heat, cover, and simmer for 15 minutes, or until liquid is absorbed and quinoa is cooked.",
            "Let cooked quinoa cool slightly.",
            "In a large bowl, combine cooled quinoa, diced cucumber, cherry tomatoes, chickpeas, red onion, and parsley.",
            "Whisk together lemon juice and olive oil. Pour over the salad and toss to combine.",
            "Season with salt and pepper.",
            "Serve chilled or at room temperature."
    ],
            preparationTime: 10,
            calories: 400,
            protein: 18,
            carbs: 55,
            fat: 12
        ),
        Recipe(
            name: "Banana and Peanut Butter on Whole Wheat Toast",
            category: .snack,
            description: "A classic and fast snack for pre-workout energy.",
            imageName: "dish14",
            ingredients: [
            "1 Slice Whole Wheat Bread",
            "1-2 tbsp Peanut Butter",
            "1/2 Banana, sliced"
    ],
            instructions: [
            "Toast the whole wheat bread to your liking.",
            "Spread peanut butter evenly over the toast.",
            "Arrange sliced banana on top of the peanut butter.",
            "Serve immediately."
    ],
            preparationTime: 2,
            calories: 280,
            protein: 10,
            carbs: 28,
            fat: 15
        ),
        Recipe(
            name: "Simple Grilled Chicken Breast",
            category: .lunch,
            description: "A versatile base for many meals, providing lean protein for muscle building and recovery.",
            imageName: "dish15",
            ingredients: [
            "150 g Chicken Breast",
            "1 tsp Olive Oil",
            "Salt, Pepper, Garlic Powder, Paprika to taste"
    ],
            instructions: [
            "Pat chicken breast dry with paper towels.",
            "Rub with olive oil and seasonings.",
            "Grill on a preheated grill or pan-fry over medium-high heat for 7-8 minutes per side, or until internal temperature reaches 74℃ and juices run clear.",
            "Let rest for a few minutes before slicing or serving whole."
    ],
            preparationTime: 5,
            calories: 250,
            protein: 35,
            carbs: 0,
            fat: 10
        ),
        Recipe(
            name: "Vegetable Omelette",
            category: .breakfast,
            description: "A nutrient-packed meal or snack, offering protein from eggs and vitamins from vegetables.",
            imageName: "dish16",
            ingredients: [
            "2 Large Eggs",
            "1 tbsp Milk (optional)",
            "1/2 Cup Mixed Vegetables, chopped (e.g., Bell Peppers, Onions, Mushrooms, Spinach)",
            "1 tsp Olive Oil or Butter",
            "Salt and Pepper to taste",
            "Optional: Cheese"
    ],
            instructions: [
            "Whisk eggs and milk (if using) in a bowl with salt and pepper.",
            "Heat olive oil or butter in a non-stick pan over medium heat.",
            "Add chopped vegetables and cook until softened, about 3-5 minutes.",
            "Pour in egg mixture over vegetables. Cook for 2-3 minutes until edges set.",
            "Sprinkle cheese if using. Fold omelette in half and cook for another 1-2 minutes until cooked through.",
            "Serve hot."
    ],
            preparationTime: 5,
            calories: 320,
            protein: 20,
            carbs: 8,
            fat: 24
        ),
        Recipe(
            name: "Brown Rice with Steamed Vegetables",
            category: .snack,
            description: "A simple side dish or base for a meal, providing complex carbohydrates and fiber.",
            imageName: "dish17",
            ingredients: [
            "1 Cup Cooked Brown Rice",
            "2 Cups Mixed Vegetables (e.g., Broccoli, Carrots, Green Beans)",
            "Water for steaming",
            "Salt and Pepper to taste"
    ],
            instructions: [
            "Cook brown rice according to package instructions.",
            "Fill a pot with about an inch of water and bring to a boil. Place a steamer basket over the water.",
            "Add vegetables to the steamer basket, cover, and steam for 5-8 minutes until tender-crisp.",
            "Season steamed vegetables with salt and pepper.",
            "Serve cooked brown rice with steamed vegetables."
    ],
            preparationTime: 5,
            calories: 280,
            protein: 6,
            carbs: 58,
            fat: 3
        ),
        Recipe(
            name: "Cottage Cheese with Pineapple Chunks",
            category: .snack,
            description: "A light, high-protein snack, good for muscle recovery.",
            imageName: "dish18",
            ingredients: [
            "1 Cup Low-Fat Cottage Cheese",
            "1/2 Cup Pineapple Chunks (fresh or canned in juice, drained)"
    ],
            instructions: [
            "Spoon cottage cheese into a bowl.",
            "Top with pineapple chunks.",
            "Serve chilled."
    ],
            preparationTime: 2,
            calories: 180,
            protein: 25,
            carbs: 12,
            fat: 4
        ),
        Recipe(
            name: "Turkey and Vegetable Skewers",
            category: .dinner,
            description: "A fun and lean protein option for grilling or baking.",
            imageName: "dish19",
            ingredients: [
            "200 g Turkey Breast, cubed",
            "1 Bell Pepper (any color), cut into chunks",
            "1 Red Onion, cut into chunks",
            "1 Zucchini, sliced thickly",
            "1 tbsp Olive Oil",
            "1 tsp Dried Herbs (e.g., Oregano, Thyme)",
            "Salt and Pepper to taste",
            "Wooden or Metal Skewers"
    ],
            instructions: [
            "If using wooden skewers, soak them in water for 30 minutes.",
            "In a bowl, toss turkey cubes and vegetables with olive oil, dried herbs, salt, and pepper.",
            "Thread turkey and vegetables onto skewers, alternating ingredients.",
            "Grill or bake in preheated oven (200℃) for 15-20 minutes, turning occasionally, until turkey is cooked through and vegetables are tender.",
            "Serve hot."
    ],
            preparationTime: 15,
            calories: 300,
            protein: 35,
            carbs: 10,
            fat: 12
        ),
        Recipe(
            name: "Spinach and Egg Muffins",
            category: .breakfast,
            description: "Portable and make-ahead protein-rich breakfast or snack.",
            imageName: "dish20",
            ingredients: [
            "6 Large Eggs",
            "1/4 Cup Milk",
            "1 Cup Chopped Spinach",
            "1/4 Cup Chopped Onion",
            "Salt and Pepper to taste",
            "Optional: Cheese, Chopped Ham or Turkey"
    ],
            instructions: [
            "Preheat oven to 180℃. Grease a muffin tin.",
            "In a bowl, whisk eggs and milk with salt and pepper.",
            "Stir in spinach and onion (and optional ingredients).",
            "Pour egg mixture evenly into the muffin cups.",
            "Bake for 18-22 minutes, or until set and cooked through.",
            "Let cool slightly before serving or storing."
    ],
            preparationTime: 10,
            calories: 100,
            protein: 8,
            carbs: 2,
            fat: 6
        ),
        Recipe(
            name: "Rice Cakes with Sliced Chicken Breast",
            category: .snack,
            description: "A simple post-workout snack combining carbs and protein.",
            imageName: "dish21",
            ingredients: [
            "2 Rice Cakes",
            "50 g Sliced Cooked Chicken Breast",
            "Optional: Mustard or Light Spread"
    ],
            instructions: [
            "Top rice cakes with sliced cooked chicken breast.",
            "Add mustard or spread if desired.",
            "Serve immediately."
    ],
            preparationTime: 5,
            calories: 180,
            protein: 18,
            carbs: 18,
            fat: 3
        ),
        Recipe(
            name: "Quinoa with Chicken and Roasted Vegetables",
            category: .dinner,
            description: "A complete and balanced meal, perfect for dinner after a demanding training.",
            imageName: "dish22",
            ingredients: [
            "1 Cup Cooked Quinoa",
            "200 g Chicken Breast, cubed",
            "2 Cups Mixed Root Vegetables (e.g., Carrots, Sweet Potatoes, Broccoli Stems), cubed",
            "1 tbsp Olive Oil",
            "Salt, Pepper, and Rosemary to taste"
    ],
            instructions: [
            "Preheat oven to 200℃.",
            "Toss cubed root vegetables with olive oil, salt, pepper, and rosemary.",
            "Spread on a baking sheet and roast for 25-30 minutes.",
            "While vegetables roast, pan-fry or bake chicken cubes until cooked through.",
            "Combine cooked quinoa, roasted vegetables, and chicken in bowls.",
            "Serve warm."
    ],
            preparationTime: 15,
            calories: 520,
            protein: 40,
            carbs: 50,
            fat: 18
        ),
        Recipe(
            name: "Scrambled Tofu with Turmeric (Vegan)",
            category: .breakfast,
            description: "A vegan alternative to scrambled eggs, rich in plant-based protein and flavor.",
            imageName: "dish23",
            ingredients: [
            "200 g Firm or Extra-Firm Tofu, pressed and crumbled",
            "1/4 Red Onion, finely chopped",
            "1/2 Cup Mushrooms, sliced",
            "1 tsp Olive Oil",
            "1/4 tsp Turmeric Powder",
            "1/4 tsp Garlic Powder",
            "Nutritional Yeast (optional, for cheesy flavor)",
            "Salt and Black Pepper to taste"
    ],
            instructions: [
            "Heat olive oil in a non-stick pan over medium heat.",
            "Add onion and mushrooms, cook until softened.",
            "Add crumbled tofu and seasonings (turmeric, garlic powder, salt, pepper, nutritional yeast).",
            "Stir and cook for 5-7 minutes, breaking up any large tofu chunks, until heated through and slightly golden.",
            "Serve hot."
    ],
            preparationTime: 5,
            calories: 200,
            protein: 18,
            carbs: 8,
            fat: 12
        ),
        Recipe(
            name: "Lentil and Vegetable Curry (Vegan)",
            category: .dinner,
            description: "A comforting and protein-packed vegan curry, perfect for a recovery dinner.",
            imageName: "dish24",
            ingredients: [
            "1 tbsp Coconut Oil or Olive Oil",
            "1 Onion, chopped",
            "2 Cloves Garlic, minced",
            "1 tbsp Ginger, minced",
            "1 tbsp Curry Powder",
            "1 tsp Garam Masala",
            "1 Cup Red or Green Lentils, rinsed",
            "4 Cups Vegetable Broth",
            "1 Can (400ml) Coconut Milk (light)",
            "2 Cups Mixed Vegetables (e.g., Cauliflower, Peas, Bell Peppers)",
            "Salt and Pepper to taste",
            "Fresh Cilantro (optional, for garnish)"
    ],
            instructions: [
            "Heat oil in a large pot over medium heat.",
            "Add onion and cook until softened, about 5-7 minutes.",
            "Stir in garlic, ginger, curry powder, and garam masala. Cook for 1-2 minutes until fragrant.",
            "Add rinsed lentils, vegetable broth, and coconut milk. Bring to a boil.",
            "Reduce heat, cover, and simmer for 20-25 minutes, or until lentils are tender.",
            "Add mixed vegetables and cook for another 8-10 minutes until tender.",
            "Season with salt and pepper.",
            "Serve hot, garnished with fresh cilantro if desired."
    ],
            preparationTime: 15,
            calories: 350,
            protein: 18,
            carbs: 38,
            fat: 15
        ),
        Recipe(
            name: "Peanut Butter and Banana Smoothie",
            category: .snack,
            description: "A quick and tasty energy boost, great before or after a workout.",
            imageName: "dish25",
            ingredients: [
            "1 Banana",
            "2 tbsp Peanut Butter",
            "1 Cup Milk or Almond Milk",
            "1 tsp Honey (optional)",
            "1/2 Cup Ice Cubes (optional)"
    ],
            instructions: [
            "Combine all ingredients in a blender.",
            "Blend until smooth.",
            "Pour into a glass and serve immediately."
    ],
            preparationTime: 5,
            calories: 400,
            protein: 15,
            carbs: 40,
            fat: 20
        ),
        Recipe(
            name: "Rice Cakes with Avocado and Everything Bagel Seasoning (Vegan)",
            category: .snack,
            description: "A simple and healthy snack, offering good fats and a bit of crunch.",
            imageName: "dish26",
            ingredients: [
            "2 Rice Cakes",
            "1/2 Avocado, mashed or sliced",
            "1 tsp Everything Bagel Seasoning"
    ],
            instructions: [
            "Top rice cakes with mashed or sliced avocado.",
            "Sprinkle with everything bagel seasoning.",
            "Serve immediately."
    ],
            preparationTime: 5,
            calories: 220,
            protein: 3,
            carbs: 18,
            fat: 18
        ),
        Recipe(
            name: "Scrambled Egg and Bean Burrito",
            category: .breakfast,
            description: "A portable and energy-rich meal, great for breakfast on the go.",
            imageName: "dish27",
            ingredients: [
            "2 Large Eggs, scrambled",
            "1/4 Cup Cooked Black Beans",
            "1 Small Whole Wheat Tortilla",
            "Optional: Salsa, Cheese"
    ],
            instructions: [
            "Scramble eggs in a pan.",
            "Warm beans in the same pan or separately.",
            "Place scrambled eggs and beans (and optional salsa/cheese) onto the whole wheat tortilla.",
            "Fold or roll the tortilla into a burrito.",
            "Serve warm."
    ],
            preparationTime: 5,
            calories: 350,
            protein: 20,
            carbs: 30,
            fat: 18
        ),
        Recipe(
            name: "Baked Chicken Breast with Lemon Herb",
            category: .lunch,
            description: "A simple and flavorful way to prepare lean protein for various meals.",
            imageName: "dish28",
            ingredients: [
            "150 g Chicken Breast",
            "1 tbsp Olive Oil",
            "1 tbsp Lemon Juice",
            "1 tsp Mixed Dried Herbs (e.g., Thyme, Rosemary, Oregano)",
            "Salt and Pepper to taste"
    ],
            instructions: [
            "Preheat oven to 200℃.",
            "Place chicken breast on a small baking sheet.",
            "Drizzle with olive oil and lemon juice.",
            "Season generously with dried herbs, salt, and pepper.",
            "Bake for 20-25 minutes, or until internal temperature reaches 74℃ and juices run clear.",
            "Let rest for a few minutes before serving."
    ],
            preparationTime: 5,
            calories: 260,
            protein: 35,
            carbs: 1,
            fat: 12
        ),
        Recipe(
            name: "Simple Tuna Salad Sandwich",
            category: .lunch,
            description: "A quick and easy classic for lunch, providing protein and energy.",
            imageName: "dish29",
            ingredients: [
            "1 Can (150g) Tuna, drained",
            "2 tbsp Mayonnaise or Greek Yogurt",
            "1/4 Celery Stalk, finely chopped",
            "Salt and Pepper to taste",
            "2 Slices Whole Wheat Bread",
            "Optional: Lettuce, Tomato"
    ],
            instructions: [
            "In a bowl, combine drained tuna, mayonnaise or Greek yogurt, and chopped celery.",
            "Season with salt and pepper. Mix well.",
            "Spread tuna mixture evenly over one slice of whole wheat bread.",
            "Top with optional lettuce/tomato and the second slice of bread.",
            "Cut in half if desired and serve."
    ],
            preparationTime: 5,
            calories: 400,
            protein: 30,
            carbs: 20,
            fat: 25
        ),
        Recipe(
            name: "Yogurt Parfait with Granola and Fruit",
            category: .snack,
            description: "A visually appealing and delicious way to combine protein, carbs, and fruit for breakfast or snack.",
            imageName: "dish30",
            ingredients: [
            "1 Cup Plain Greek Yogurt",
            "1/2 Cup Granola",
            "1/2 Cup Mixed Berries or other fruit, sliced",
            "Optional: Drizzle of Honey"
    ],
            instructions: [
            "In a tall glass or bowl, layer half of the yogurt, half of the granola, and half of the fruit.",
            "Repeat layers with remaining ingredients.",
            "Drizzle with honey if desired.",
            "Serve immediately."
    ],
            preparationTime: 5,
            calories: 300,
            protein: 20,
            carbs: 35,
            fat: 10
        )
    ]
}
