//
//  HomeView.swift
//  SamokatDemo
//
//  Created by Илья Казначеев on 28.06.2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct HomeView: View {
    
    @ObservedObject private var viewModel: CategoryVM = CategoryVM()
    @State var path: NavigationPath = .init()
    
    var body: some View {
        NavigationStack(path: $path) {
            R.Colors.background
                .frame(height: 4)
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible())], spacing: 8) {
                    ForEach(viewModel.categories, id: \.name) { category in
                        CategoryCell(category: category)
                            .frame(height: (UIScreen.screenWidth - 32) * 0.43148688046)
                            .cornerRadius(10)
                            .onTapGesture {
                                path.append(category)
                                DishVM.shared.teg = .всеМеню
                            }
                    }
                }
                .padding(.leading)
                .padding(.trailing)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    LeftNavBarItem()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    R.Images.user
                }
            }
            .navigationDestination(for: EMCategory.self) { category in
                CategoryView(category: category)
            }
        }
    }
}

struct LeftNavBarItem: View {
    
    @State private var date = ""
    @ObservedObject private var locationManager = LocationManager.shared
    
    var body: some View {
        HStack {
            R.Images.location
                .frame(width: 24, height: 24)
                .padding(.bottom, 12)
                .padding(.trailing, -4)
            VStack(alignment: .leading, spacing: 4) {
                Text(locationManager.city)
                    .font(R.Fonts.SF_Pro_Display(18, .medium))
                    .foregroundColor(R.Colors.label)
                Text(date)
                    .font(R.Fonts.SF_Pro_Display(14, .regular))
                    .foregroundColor(R.Colors.secondaryLabel)
            }
        }
        .padding(.bottom)
        .padding(.top)
        .onAppear {
            updateDate()
        }
    }
    
    private func updateDate() {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "dd MMMM, yyyy"
        date = formatter.string(from: Date())
    }
}

struct CategoryCell: View {
    
    let category: EMCategory
    
    var body: some View {
        ZStack {
            WebImage(url: URL(string: category.imageURL))
                .resizable()
                .placeholder {
                    ProgressView()
                }
                .scaledToFit()
            HStack {
                VStack(alignment: .leading) {
                    Text(category.name)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(R.Colors.label)
                        .font(R.Fonts.SF_Pro_Display(20, .medium))
                        .lineLimit(2)
                        .padding(.top, 12)
                        .padding(.leading, 16)
                        .frame(maxWidth: 191, alignment: .leading)
                    Spacer()
                }
                Spacer()
            }
        }
    }
}
