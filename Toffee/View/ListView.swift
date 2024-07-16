//
//  ListView.swift
//  Toffee
//
//  Created by Md Abir Hossain on 16/7/24.
//

import SwiftUI

struct ListView: View {
    var body: some View {
        VStack {
            
        }
        .profileNavigationToolbar(title: ConstantsProfile.EditProfile.navTitle, isTitle: true, isSearch: true, isNotification: true)
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(false)
    }
}

#Preview {
    ListView()
}
