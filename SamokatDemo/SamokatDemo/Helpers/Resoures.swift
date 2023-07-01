//
//  Resoures.swift
//  SamokatDemo
//
//  Created by Илья Казначеев on 28.06.2023.
//

import SwiftUI

enum R {
    
    enum Colors {
        static let label = Color("1label")
        static let secondaryLabel = Color("2label")
        static let tertiaryLabel = Color("3label")
        static let quaternaryLabel = Color("4label")
        
        static let background = Color("background")
        static let secondaryBackground = Color("2background")
        static let primary = Color("primary")
        static let inactive = Color("inactive")
        static let separator = Color("separator")
        static let stepper = Color("stepper")
    }
    
    enum TabBar {
        
        static func getTitleFor(_ tab: Tabs) -> String {
            switch tab {
                case .main: return "Главная"
                case .search: return "Поиск"
                case .cart: return "Корзина"
                case .account: return "Аккаунт"
            }
        }
        
        static func getImageFor(_ tab: Tabs) -> Image {
            switch tab {
                case .main: return Image("home")
                case .search: return Image("search-normal")
                case .cart: return Image("bag")
                case .account: return Image("profile-circle")
            }
        }
    }
    
    enum Fonts {
        static func SF_Pro_Display(_ size: CGFloat, _ type: Font.Weight) -> Font {
            switch type {
                case .regular:
                    return Font.custom("SFPRODISPLAYREGULAR", size: size)
                case .medium:
                    return Font.custom("SFPRODISPLAYMEDIUM", size: size)
                default:
                    return Font.custom("SFPRODISPLAYREGULAR", size: size)
            }
        }
    }
    
    enum Images {
        static let dismiss = Image("dismiss")
        static let heart = Image("heart")
        static let location = Image("location")
        static let user = Image("user")
        static let back = Image("back")
        static let minus = Image("minus")
        static let plus = Image("plus")
    }
    
    enum API {
        static let base = "https://run.mocky.io/v3/"
        static let categotyEndpoint = "058729bd-1402-4578-88de-265481fd7d54"
        static let dishEndpoint = "aba7ecaa-0a70-453b-b62d-0e326c859b3b"
    }
}
