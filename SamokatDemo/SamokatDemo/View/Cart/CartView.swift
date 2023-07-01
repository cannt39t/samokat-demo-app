//
//  CartView.swift
//  SamokatDemo
//
//  Created by Илья Казначеев on 28.06.2023.
//

import SwiftUI

struct CartView: View {
    
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\EMCartItem.adddedAt, order: .reverse)
    ])
    var cartItems: FetchedResults<EMCartItem>
    
    @State var path: NavigationPath = .init()
    
    var body: some View {
        NavigationStack(path: $path) {
            R.Colors.background
                .frame(height: 4)
            ZStack {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible())], spacing: 0) {
                        ForEach(cartItems, id: \.id) { cartItem in
                            CartCellView(cartItem: cartItem)
                                .frame(height: 62)
                                .padding(8)
                        }
                    }
                    .padding(.horizontal, 8)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        LeftNavBarItem()
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        R.Images.user
                    }
                }
                VStack {
                    Spacer()
                    Button {
                        
                    } label: {
                        let totalPrice = Float(cartItems.reduce(0, { $0 + Float($1.price) * Float($1.count) }))
                        let formattedPrice = NumberFormatter.localizedString(from: NSNumber(value: totalPrice), number: .decimal)
                        let formattedPrice1 = formattedPrice.replacingOccurrences(of: ",", with: " ")
                        Text("Оплатить \(formattedPrice1) ₽")
                            .font(R.Fonts.SF_Pro_Display(16, .medium))
                            .frame(maxWidth: .infinity)
                            .frame(height: 48)
                            .foregroundColor(.white)
                            .background(R.Colors.primary)
                            .cornerRadius(10)
                            .padding()
                    }
                }
            }
        }
    }
}

struct CartCellView: View {
    
    @ObservedObject var cartItem: EMCartItem
    
    var body: some View {
        HStack {
            HStack {
                ZStack {
                    R.Colors.secondaryBackground
                        .cornerRadius(6)
                    AsyncImage(url: URL(string: cartItem.imageURL ?? "")) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .padding(8)
                    } placeholder: {
                        ProgressView()
                    }
                }
                .frame(width: 62)
                VStack(alignment: .leading, spacing: 4) {
                    Text(cartItem.name ?? "")
                        .font(R.Fonts.SF_Pro_Display(14, .regular))
                        .foregroundColor(R.Colors.label)
                        .lineLimit(2)
                    Text("\(cartItem.price) ₽")
                        .font(R.Fonts.SF_Pro_Display(14, .regular))
                        .foregroundColor(R.Colors.label) +
                    Text(" · \(cartItem.weight)г")
                        .font(R.Fonts.SF_Pro_Display(14, .regular))
                        .foregroundColor(R.Colors.quaternaryLabel)
                }
            }
            Spacer()
            CustomStepper(cartItem: cartItem)
                .padding()
        }
    }
}

struct CustomStepper: View {
    
    @ObservedObject var cartItem: EMCartItem
    @Environment(\.self) private var env
    
    var body: some View {
        HStack(spacing: 16) {
            R.Images.minus
                .onTapGesture {
                    cartItem.count -= 1
                    if cartItem.count == 0 {
                        env.managedObjectContext.delete(cartItem)
                    }
                    try? env.managedObjectContext.save()
                }
            Text("\(cartItem.count)")
                .font(R.Fonts.SF_Pro_Display(14, .medium))
            R.Images.plus
                .scaledToFit()
                .frame(width: 24, height: 24)
                .onTapGesture {
                    cartItem.count += 1
                    try? env.managedObjectContext.save()
                }
        }
        .frame(height: 32)
        .padding(.horizontal, 6)
        .background(R.Colors.stepper)
        .cornerRadius(10)
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
