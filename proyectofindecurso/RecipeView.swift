//
//  RecipeView.swift
//  proyectofindecurso
//
//  Created by Jeanpierre on 2/5/24.
//

import SwiftUI

struct RecipeView: View {
    var recipe: Recipe

       var body: some View {
           ScrollView {
               VStack(alignment: .leading, spacing: 20) {
                   Text(recipe.name)
                       .font(.title)
                       .padding()
                   
                   Text("Descripcion:")
                       .font(.headline)
                       .padding(.leading)

                   Text(recipe.recipeDescription)
                       .padding(.leading)

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
                   }

                   // Agregar la receta
                   

                   // Agregar la preparación
                   Text("Preparación:")
                       .font(.headline)
                       .padding(.vertical,10)

                   Text(recipe.preparation)
                       .padding(.vertical,10)

                   // Agregar la imagen del platillo al final
                   Image(recipe.imageName)
                       .resizable()
                       .aspectRatio(contentMode: .fit)
                       .cornerRadius(10)
                       .padding()
               }
               .navigationBarTitle("Receta", displayMode: .inline)
           }
       }
   //}
