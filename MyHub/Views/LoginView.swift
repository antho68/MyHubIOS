//
//  LoginView.swift
//  MyHub
//
//  Created by Anthony Baumle on 03/04/2023.
//

import SwiftUI

extension View {
	func underlineTextField() -> some View {
		self
			.overlay(Rectangle().frame(height: 2).padding(.top, 35))
			.foregroundColor(MyHubUtils.textColor)
			.padding(20)
	}
}

struct LoginView: View {
	
	@State var name: String = ""
	@State var password: String = ""
	@State var showPassword: Bool = false
	@State var showErrorLabel: Bool = false
	@State var showSignUp: Bool = false
	@State var user: User?
	@State private var isPerformingTask = false
	
	@Binding var signInSuccess: Bool
	
	var isSignInButtonDisabled: Bool {
			[name, password].contains(where: \.isEmpty)
		}
	
    var body: some View {
		
			VStack(alignment: .leading, spacing: 15)
			{
				if (!showSignUp)
				{
					Spacer()
					
					HStack{
						Spacer()
						
						Image("MyHubLogo").resizable()
							.aspectRatio(contentMode: .fit)
							.frame(width: .infinity, alignment: .center)
							.padding()
						
						Spacer()
					}
					
					TextField(NSLocalizedString("loginView.Login", comment: ""),
							  text: $name ,
							  prompt: Text(NSLocalizedString("loginView.Login", comment: "")).foregroundColor(MyHubUtils.textColor)
					)
					.underlineTextField()
					
					HStack {
						Group {
							if showPassword {
								TextField(NSLocalizedString("loginView.Password", comment: ""),
										  text: $password,
										  prompt: Text(NSLocalizedString("loginView.Password", comment: ""))
									.foregroundColor(MyHubUtils.textColor))
							} else {
								SecureField(NSLocalizedString("loginView.Password", comment: ""),
											text: $password,
											prompt: Text(NSLocalizedString("loginView.Password", comment: ""))
									.foregroundColor(MyHubUtils.textColor))
							}
						}
						
						Button {
							showPassword.toggle()
						} label: {
							Image(systemName: showPassword ? "eye.slash" : "eye")
								.foregroundColor(MyHubUtils.textColor)
						}
						
					}
					.underlineTextField()
					
					Spacer()
					
					if (showErrorLabel)
					{
						Text(NSLocalizedString("loginView.CannotLogIn", comment:"")).foregroundColor(.red).bold().font(.title2).padding()
					}
					
					Button(
						action: {
							isPerformingTask = true
						
							Task {
								await doSignId()
								isPerformingTask = false
							}
						}
					)
					{
						HStack{
							Text(NSLocalizedString("loginView.SignIn", comment: "")).foregroundColor(MyHubUtils.textColor).bold().font(.title2)
						}
					}
					.frame(height: 50)
					.frame(maxWidth: .infinity)
					.background(MyHubUtils.mainActionColor)
					.cornerRadius(20)
					.padding()
					
					Button(action: doSignUp)
					{
						HStack{
							Text(NSLocalizedString("loginView.SignUp", comment: "")).foregroundColor(MyHubUtils.textColor).bold().font(.title2)
							Divider()
							Image(systemName: "arrowshape.right").resizable().frame(width: 25, height: 25).foregroundColor(MyHubUtils.textColor).bold()
						}
					}
					.frame(height: 50)
					.frame(maxWidth: .infinity)
					.background(MyHubUtils.actionColor)
					.cornerRadius(20)
					.padding()
				}
				else
				{
					Spacer()
					
					HStack{
						Spacer()
						
						Image("MyHubLogo").resizable()
							.aspectRatio(contentMode: .fit)
							.frame(width: .infinity, alignment: .center)
							.frame(maxWidth:400)
							.padding()
						
						Spacer()
					}
					
					TextField(NSLocalizedString("loginView.Login", comment: ""),
							  text: $name ,
							  prompt: Text(NSLocalizedString("loginView.Login", comment: "")).foregroundColor(MyHubUtils.textColor)
					)
					.underlineTextField()
					
					TextField(NSLocalizedString("loginView.Firstname", comment: ""),
							  text: $name ,
							  prompt: Text(NSLocalizedString("loginView.Firstname", comment: "")).foregroundColor(MyHubUtils.textColor)
					)
					.underlineTextField()
					
					TextField(NSLocalizedString("loginView.Lastname", comment: ""),
							  text: $name ,
							  prompt: Text(NSLocalizedString("loginView.Lastname", comment: "")).foregroundColor(MyHubUtils.textColor)
					)
					.underlineTextField()
					
					TextField(NSLocalizedString("loginView.Password", comment: ""),
							  text: $name ,
							  prompt: Text(NSLocalizedString("loginView.Password", comment: "")).foregroundColor(MyHubUtils.textColor)
					)
					.underlineTextField()
					
					TextField(NSLocalizedString("loginView.PasswordReDo", comment: ""),
							  text: $name ,
							  prompt: Text(NSLocalizedString("loginView.PasswordReDo", comment: "")).foregroundColor(MyHubUtils.textColor)
					)
					.underlineTextField()
					
					Spacer()
					
					Button(action: createUser)
					{
						HStack{
							Text(NSLocalizedString("loginView.CreateUser", comment: "")).foregroundColor(MyHubUtils.textColor).bold().font(.title2)
						}
						
						
					}
					.frame(height: 50)
					.frame(maxWidth: .infinity)
					.background(MyHubUtils.mainActionColor)
					.cornerRadius(20)
					.padding()
									
					Button(action: backToSignIn)
					{
						HStack{
							Image(systemName: "arrowshape.left").resizable().frame(width: 25, height:25).foregroundColor(MyHubUtils.textColor).bold()
							Divider()
							Text(NSLocalizedString("loginView.BackToSignIn", comment:"")).foregroundColor(MyHubUtils.textColor).bold().font(.title2)
						}
					}
					.frame(height: 50)
					.frame(maxWidth: .infinity)
					.background(MyHubUtils.actionColor)
					.cornerRadius(20)
					.padding()
				}
				
			}.padding(.vertical)
				.background(LinearGradient(colors:[ MyHubUtils.primaryColor.opacity(0.5), MyHubUtils.primaryColor], startPoint: .topLeading, endPoint: .bottomTrailing))
	}
	
	func doSignId() async {
		print("Sign id")
		
		do {
			user = try await LoginController().tryConnection(userId: name, password: password)
		}
		catch HubError.WebMyHubRestError.invalidURL {
			print("Invalid URL")
		}
		catch HubError.WebMyHubRestError.invalidData {
			print("Invalid Data")
		}
		catch HubError.WebMyHubRestError.invalidResponse {
			print("Invalid Response")
		}
		catch
		{
			print("Other error")
		}
		
		if (user != nil)
		{
			self.signInSuccess = true
			
			persistenceController.container.viewContext
		}
		else
		{
			showErrorLabel = true
		}
	}
	
	func doSignUp()
	{
		print("Sign Up")
		
		showSignUp = true
	}
	
	func createUser()
	{
		print("Sign Up")
	}
	
	func backToSignIn()
	{
		print("Back to Sign Up")
		showSignUp = false
	}
}

struct LoginView_Previews: PreviewProvider {
	@State static var signInSuccess = false
	
    static var previews: some View {
		LoginView(signInSuccess: $signInSuccess)
    }
}
