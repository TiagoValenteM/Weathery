//
//  LoadingView.swift
//  WeatherApp
//
//  Created by Tiago Valente on 27/01/2023.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: .white))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .shadow(color: Color(red: 0, green: 0, blue: 0.6), radius: 5.0, x: 3.0, y: 5.0)
            .scaleEffect(1.3, anchor: .center)
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
