//
//  DishPresentView.swift
//  SamokatDemo
//
//  Created by Илья Казначеев on 30.06.2023.
//

import SwiftUI

struct DishCartView: View {
    
    
    @Binding var dish: EMDish?
    @EnvironmentObject private var alertManager: DishCartPresentManager
    @Environment(\.self) private var env
    @FetchRequest(sortDescriptors: [])
    var cartItems: FetchedResults<EMCartItem>
    
    var body: some View {
        VStack(spacing: 5) {
            ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
                ZStack {
                    R.Colors.secondaryBackground
                        .cornerRadius(10)
                    ZStack {
                        AsyncImage(url: URL(string: dish!.imageURL)) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .padding(12)
                        } placeholder: {
                            ProgressView()
                        }
                    }
                }
                HStack {
                    Group {
                        Image("heart")
                            .frame(width: 40, height: 40)
                        Image("dismiss")
                            .frame(width: 40, height: 40)
                            .onTapGesture {
                                alertManager.isPresent = false
                            }
                    }
                    .background(R.Colors.background)
                    .cornerRadius(8)
                }
                .padding(8)
            }
            .frame(height: 232)
            .padding([.horizontal, .top])
            .padding(.bottom, 8)
            VStack(alignment: .leading, spacing: 8) {
                Text(dish!.name)
                    .font(R.Fonts.SF_Pro_Display(16, .medium))
                    .foregroundColor(R.Colors.label)
                Text("\(dish!.price) ₽ ")
                    .font(R.Fonts.SF_Pro_Display(14, .regular))
                    .foregroundColor(R.Colors.label) +
                Text("· \(dish!.weight)г")
                    .font(R.Fonts.SF_Pro_Display(14, .regular))
                    .foregroundColor(R.Colors.quaternaryLabel)
                Text(dish!.description)
                    .font(R.Fonts.SF_Pro_Display(14, .regular))
                    .foregroundColor(R.Colors.tertiaryLabel)
                Button {
                    addToCart()
                    alertManager.isPresent = false
                } label: {
                    Text("Добавить в корзину")
                        .frame(maxWidth: .infinity)
                        .frame(height: 48)
                        .foregroundColor(.white)
                        .font(R.Fonts.SF_Pro_Display(16, .medium))
                        .background(R.Colors.primary)
                        .cornerRadius(10)
                        .padding(.top, 8)
                }
            }
            .padding([.horizontal, .bottom], 16)
        }
        .background(Color.white)
        .cornerRadius(15)
        .padding()
    }
    
    private func addToCart() {
        guard let dishVal = dish else { return }
        if cartItems.contains(where: { $0.id == Int64(dishVal.id)}) { return }
        do {
            let cartItem = EMCartItem(context: env.managedObjectContext)
            cartItem.id = Int64(dishVal.id)
            cartItem.imageURL = dishVal.imageURL
            cartItem.adddedAt = Date()
            cartItem.name = dishVal.name
            cartItem.price = Int64(dishVal.price)
            cartItem.count = 1
            cartItem.weight = Int64(dishVal.weight)
            
            try env.managedObjectContext.save()
            print("didSave")
        } catch {
            print(error.localizedDescription)
        }
    }
}
