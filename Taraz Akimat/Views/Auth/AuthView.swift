import SwiftUI

struct AuthView: View {
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false
    @StateObject private var profileVM = UserProfileViewModel()
    
    @State private var phone: String = ""
    @State private var code: String = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
                
                VStack(spacing: 24) {
                    Spacer()
                    
                    VStack(spacing: 8) {
                        Text("Taraz Akimat")
                            .font(.largeTitle.bold())
                        Text("auth_subtitle".loc)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                    VStack(spacing: 16) {
                        TextField("+7 7__", text: $phone)
                            .keyboardType(.phonePad)
                            .textContentType(.telephoneNumber)
                            .padding()
                            .background(Color(.systemBackground))
                            .cornerRadius(12)
                        
                        SecureField("Код из SMS (демо)", text: $code)
                            .keyboardType(.numberPad)
                            .padding()
                            .background(Color(.systemBackground))
                            .cornerRadius(12)
                    }
                    .padding(.horizontal)
                    
                    Button {
                        // простая проверка (в демо всё равно)
                        if !phone.isEmpty {
                            profileVM.phone = phone
                            if profileVM.name == "Имя пользователя" {
                                profileVM.name = "Житель Тараза"
                            }
                            profileVM.save()
                            
                            isLoggedIn = true
                        }
                    } label: {
                        Text("Войти")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(PrimaryButtonStyle())
                    .padding(.horizontal)
                    
                    Text("auth_hint".loc)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    Spacer()
                }
            }
            .navigationTitle("auth_title".loc)
        }
    }
}
