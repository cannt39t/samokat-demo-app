//
//  CategoryView.swift
//  SamokatDemo
//
//  Created by Илья Казначеев on 29.06.2023.
//

import SwiftUI

struct CategoryView: View {
    
    var category: EMCategory
    @ObservedObject var viewModel: DishVM = DishVM()
    @EnvironmentObject private var alertManager: DishCartPresentManager
    @Environment(\.dismiss) private var dismiss
    
    private let colums = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            R.Colors.background
                .frame(height: 4)
            ScrollView {
                ScrollViewReader { scrollViewProxy in
                    ScrollView(.horizontal) {
                        LazyHStack(spacing: 8) {
                            ForEach(Teg.allCases, id: \.rawValue) { teg in
                                TegCell(isSelected: teg == viewModel.teg, teg: teg)
                                    .onTapGesture {
                                        viewModel.teg = teg
                                    }
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                    .onChange(of: viewModel.teg) { newElementID in
                        withAnimation {
                            scrollViewProxy.scrollTo(newElementID, anchor: .center)
                        }
                    }
                }
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                    ForEach(viewModel.dishes, id: \.name) { dish in
                        ProductCell(dish: dish)
                            .frame(height: (UIScreen.screenWidth / 3) * 1.32110091743 - 16)
                            .onTapGesture {
                                alertManager.dish = dish
                                withAnimation {
                                    alertManager.isPresent = true
                                }
                            }
                    }
                }
                .padding([.leading, .trailing])
                .padding([.top, .bottom], 8)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                         dismiss()
                    } label: {
                        R.Images.back.renderingMode(.template)
                            .foregroundColor(R.Colors.label)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    R.Images.user
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationTitle(category.name)
            .navigationBarTitleDisplayMode(.inline)
            .font(R.Fonts.SF_Pro_Display(18, .medium))
        }
    }
}

struct TegCell: View {
    
    var isSelected: Bool
    var teg: Teg
    
    var body: some View {
        Text(teg.rawValue)
            .font(R.Fonts.SF_Pro_Display(14, .regular))
            .padding([.leading, .trailing], 16)
            .padding([.top, .bottom], 10)
            .background(isSelected ? R.Colors.primary : R.Colors.secondaryBackground)
            .foregroundColor(isSelected ? R.Colors.background : R.Colors.label)
            .cornerRadius(10)
            .padding(.leading, teg == .всеМеню ? 16 : 0)
            .padding(.trailing, teg == .роллы ? 16 : 0)
            .id(teg)
    }
}

struct ProductCell: View {
    
    var dish: EMDish
    
    var body: some View {
        VStack(spacing: 5) {
            ZStack {
                R.Colors.secondaryBackground
                    .cornerRadius(10)
                ZStack {
                    AsyncImage(url: URL(string: dish.imageURL)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .padding(12)
                    } placeholder: {
                        ProgressView()
                    }
                }
            }
            VStack {
                Text(dish.name)
                    .foregroundColor(R.Colors.label)
                    .font(R.Fonts.SF_Pro_Display(14, .regular))
                    .lineLimit(2, reservesSpace: true)
                    .frame(width: (UIScreen.screenWidth / 3 - 16), alignment: .leading)
            }
        }
    }
}
