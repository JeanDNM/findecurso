//
//  ContentView.swift
//  proyectofindecurso
//
//  Created by Jeanpierre on 2/5/24.
//

import SwiftUI

struct Recipe: Identifiable {
    var id = UUID()
    var name: String
    var imageName: String
    var ingredients: [String]
    var instructions: [String]
    var recipeDescription: String
    var preparation: String
    var isFavorite: Bool = false
}

class RecipesManager: ObservableObject {
    @Published var recipes: [Recipe]
    
    init(recipes: [Recipe]) {
        self.recipes = recipes
    }
    
    func toggleFavorite(recipe: Recipe) {
        if let index = recipes.firstIndex(where: { $0.id == recipe.id }) {
            recipes[index].isFavorite.toggle()
        }
    }
    
    func filteredRecipes(showFavoritesOnly: Bool) -> [Recipe] {
        if showFavoritesOnly {
            return recipes.filter { $0.isFavorite }
        } else {
            return recipes
        }
    }
}

struct ContentView: View {
    @StateObject var recipesManager = RecipesManager(recipes: [
        Recipe(name: "Anticucho Carretillero", imageName: "anticucho", ingredients: ["Carne de res", "Papas", "Maíz"], instructions: ["Instrucciones para preparar el anticucho carretillero"], recipeDescription: "El anticucho es un plato tradicional peruano que consiste en brochetas de carne de res marinadas y asadas a la parrilla.", preparation: "Marinar la carne en una mezcla de especias y luego ensartarla en palitos de madera junto con las papas y el maíz. Asar a la parrilla hasta que estén cocidos."),
        Recipe(name: "Ceviche Peruano", imageName: "ceviche", ingredients: ["Filete de pescado blanco", "Limón", "Cebolla roja", "Ají amarillo", "Cilantro"], instructions: ["Instrucciones para preparar el ceviche peruano"], recipeDescription: "El ceviche peruano es un plato de pescado crudo marinado en jugo de limón, con cebolla roja, ají amarillo y cilantro.", preparation: "Cortar el pescado en trozos pequeños y marinarlo en jugo de limón. Agregar cebolla roja, ají amarillo y cilantro picado. Dejar reposar en el refrigerador antes de servir."),
        Recipe(name: "Causa Limeña", imageName: "causa", ingredients: ["Papas amarillas", "Ají amarillo", "Limón", "Aguacate", "Atún enlatado"], instructions: ["Instrucciones para preparar la causa limeña"], recipeDescription: "La causa limeña es un plato típico peruano que consiste en una especie de pastel frío hecho a base de papas amarillas, ají amarillo y limón, relleno de atún o pollo.", preparation: "Hervir las papas amarillas y luego hacerlas puré. Mezclar con ají amarillo y limón para formar la masa de la causa. Rellenar con atún y aguacate y refrigerar antes de servir.")
    ])
    @State private var showFavoritesOnly = false
    @EnvironmentObject private var authModel: AuthViewModel
    
    var body: some View {
        NavigationView {
            List(recipesManager.filteredRecipes(showFavoritesOnly: showFavoritesOnly), id: \.id) { recipe in
                NavigationLink(destination: RecipeView(recipe: recipe)) {
                    BasicImageRow(recipe: recipe)
                        .contextMenu {
                            Button(action: {
                                recipesManager.toggleFavorite(recipe: recipe)
                            }) {
                                if recipe.isFavorite {
                                    Label("Remover de favoritos", systemImage: "heart.slash.fill")
                                } else {
                                    Label("Añadir a favoritos", systemImage: "heart.fill")
                                }
                            }
                        }
                }
            }
            .navigationBarTitle("Recetas Peruanas")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: SettingsView(showFavoritesOnly: $showFavoritesOnly)) {
                        Image(systemName: "gearshape")
                    }
                }
            }
        }
    }
}

struct SettingsView: View {
    @Binding var showFavoritesOnly: Bool
    
    var body: some View {
        Toggle("Mostrar solo favoritos", isOn: $showFavoritesOnly)
            .padding()
    }
}

struct ReciveView: View {
    var recipe: Recipe
    
    var body: some View {
        ScrollView {
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

                Text("Instrucciones:")
                    .font(.headline)
                    .padding(.leading)

                ForEach(recipe.instructions, id: \.self) { instruction in
                    Text("- \(instruction)")
                        .padding(.leading)
                }

                Text("Receta:")
                    .font(.headline)
                    .padding(.leading)

                Text(recipe.recipeDescription)
                    .padding(.leading)

                Text("Preparación:")
                    .font(.headline)
                    .padding(.leading)

                Text(recipe.preparation)
                    .padding(.leading)

                Image(recipe.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
            }
            .navigationBarTitle("Recipe")
        }
    }
}

struct BasicImageRow: View {
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


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
