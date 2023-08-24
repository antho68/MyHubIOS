//
//  ContentView.swift
//  MyHub
//
//  Created by Anthony Baumle on 03/04/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

	@State var ConnectionWorked: Bool = false

    var body: some View
	{
        if (!ConnectionWorked)
		{
			LoginView(signInSuccess: $ConnectionWorked)
		}
		else
		{
			HomeView()
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
