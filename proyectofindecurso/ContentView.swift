//
//  ContentView.swift
//  proyectofindecurso
//
//  Created by Jeanpierre on 2/5/24.
//

import SwiftUI
struct Recipe {
    var name: String
    var imageName:String
    var recipeDescription: String
    var ingredients: [String]
    //var instructions: [String]
    
    var preparation: String
    
}

struct ContentView: View {
            var recipes = [
               Recipe(name: "Anticucho Carretillero",
                      imageName: "anticucho",
                      recipeDescription: "El anticucho es un plato tradicional peruano que consiste en brochetas de carne de res marinadas y asadas a la parrilla.",
                      ingredients: ["Carne de res", "Papas", "Maíz"],
                     /* instructions: ["Instrucciones para preparar el anticucho carretillero"],*/
                      
                      preparation: "Marinar la carne en una mezcla de especias y luego ensartarla en palitos de madera junto con las papas y el maíz. Asar a la parrilla hasta que estén cocidos."),
               
               Recipe(name: "Ceviche Peruano",
                      imageName: "ceviche",
                      recipeDescription: "El ceviche peruano es un plato de pescado crudo marinado en jugo de limón, con cebolla roja, ají amarillo y cilantro.",
                      ingredients: ["Filete de pescado blanco", "Limón", "Cebolla roja", "Ají amarillo", "Cilantro"],
                      /*instructions: ["Instrucciones para preparar el ceviche peruano"],*/
                      
                      preparation: "Cortar el pescado en trozos pequeños y marinarlo en jugo de limón. Agregar cebolla roja, ají amarillo y cilantro picado. Dejar reposar en el refrigerador antes de servir."),
               
               Recipe(name: "Causa Limeña",
                      imageName: "causa",
                      recipeDescription: "La causa limeña es un plato típico peruano que consiste en una especie de pastel frío hecho a base de papas amarillas, ají amarillo y limón, relleno de atún o pollo.",
                      ingredients: ["Papas amarillas", "Ají amarillo", "Limón", "Aguacate", "Atún enlatado"],
                      /*instructions: ["Instrucciones para preparar la causa limeña"],*/
                      
                      preparation: "Hervir las papas amarillas y luego hacerlas puré. Mezclar con ají amarillo y limón para formar la masa de la causa. Rellenar con atún y aguacate y refrigerar antes de servir.")
           ]
           
    
    var body: some View {
        NavigationView {
            List(recipes, id: \.name) { recipe in
                NavigationLink(destination: RecipeView(recipe: recipe)) {
                    BasicImageRow(recipe: recipe/*name: recipe.name*/)
                }
            }
            .navigationBarTitle("Platos Típicos", displayMode: .inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct BasicImageRow: View {
   /* var name: String
    
    var body: some View {
        Text(name)
            .padding()
    }*/
    var recipe: Recipe
        
        var body: some View {
            HStack {
                Image(recipe.imageName)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .cornerRadius(5)
                Text(recipe.name)
                    .padding()
            }
        }
}

struct Recipes: View {
    var recipe: Recipe

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(recipe.name)
                .font(.title)
                .padding()

            Text("Ingredientes:")
                .font(.headline)
                .padding(.leading)

            ForEach(recipe.ingredients, id: \.self) { ingredient in
                Text("- \(ingredient)")
                    .padding(.leading)
            }

            /*Text("Instrucciones:")
                .font(.headline)
                .padding(.leading)

            ForEach(recipe.instructions, id: \.self) { instruction in
                Text("- \(instruction)")
                    .padding(.leading)*/
           // }
        }
        .navigationBarTitle("Receta", displayMode: .inline)
    }
}
