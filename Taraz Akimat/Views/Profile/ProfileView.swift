import SwiftUI

struct ProfileView: View {
    @StateObject private var profileVM = UserProfileViewModel()
    @State private var showingEditProfile = false
    @State private var showStats = false
    @EnvironmentObject var languageManager: LanguageManager


    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false
    @StateObject private var statsVM = ProfileStatsViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 16) {
                        
                        // Шапка профиля
                        profileHeader
                            .padding(.horizontal)
                            .padding(.top, 12)
                        
                        // Статистика
                        statsSection
                            .padding(.horizontal)
                        
                        // Настройки
                        settingsSection
                            .padding(.horizontal)
                        
                        Spacer(minLength: 20)
                    }
                }
            }
            .navigationTitle("Аккаунт")
            .sheet(isPresented: $showingEditProfile) {
                EditProfileView(viewModel: profileVM)
            }
            .onAppear {
                statsVM.refresh()
                showStats = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    showStats = true
                }
            }
        }
    }
    
    // MARK: - Views
    
    private var profileHeader: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 14) {
                ZStack {
                    Circle()
                        .fill(Color.accentColor.opacity(0.15))
                        .frame(width: 64, height: 64)
                    
                    Image(systemName: "person.fill")
                        .font(.system(size: 30, weight: .medium))
                        .foregroundColor(.accentColor)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(profileVM.name)
                        .font(.title3.bold())
                    Text(profileVM.phone)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
            }
            
            Button {
                showingEditProfile = true
            } label: {
                HStack(spacing: 6) {
                    Image(systemName: "pencil")
                    Text("profile_edit".loc)
                }
                .font(.subheadline.weight(.medium))
                .foregroundColor(.accentColor)
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 3)
        )
    }
    
    private var statsSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("profile_activity".loc)
                .font(.headline)
                .padding(.horizontal, 4)
            
            HStack(spacing: 12) {
                StatCard(
                    title: "Заявки",
                    value: "\(statsVM.requestsCount)",
                    systemImage: "exclamationmark.bubble",
                    color: .orange
                )
                
                StatCard(
                    title: "Записи",
                    value: "\(statsVM.appointmentsCount)",
                    systemImage: "calendar.badge.clock",
                    color: .blue
                )
                
                StatCard(
                    title: "Опросы",
                    value: "\(statsVM.pollsCount)",
                    systemImage: "chart.bar",
                    color: .green
                )
            }
        }
        .opacity(showStats ? 1 : 0)
        .offset(y: showStats ? 0 : 20)
        .animation(.spring(response: 0.6, dampingFraction: 0.8), value: showStats)
    
    }
    
    private var settingsSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("profile_settings".loc)
                .font(.headline)
                .padding(.horizontal, 4)
            
            VStack(spacing: 0) {
                // Язык
                NavigationLink {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("settings_language".loc)
                            .font(.headline)
                        
                        Button {
                            languageManager.selectedLanguage = "ru"
                        } label: {
                            HStack {
                                Text("language_ru".loc)
                                Spacer()
                                if languageManager.selectedLanguage == "ru" {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.accentColor)
                                }
                            }
                        }
                        
                        Button {
                            languageManager.selectedLanguage = "kk"
                        } label: {
                            HStack {
                                Text("language_kz".loc)
                                Spacer()
                                if languageManager.selectedLanguage == "kk" {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.accentColor)
                                }
                            }
                        }
                        
                        Button {
                            languageManager.selectedLanguage = "en"
                        } label: {
                            HStack {
                                Text("language_en".loc)
                                Spacer()
                                if languageManager.selectedLanguage == "en" {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.accentColor)
                                }
                            }
                        }
                        
                        Spacer()
                    }
                    .padding()
                    .navigationTitle("settings_language".loc)
                } label: {
                    SettingsRowView(
                        title: "settings_language".loc,
                        subtitle: "",
                        systemImage: "globe"
                    )
                    .padding(.vertical, 10)
                    .padding(.horizontal, 12)
                }
                
                Divider().padding(.leading, 52)
                
                // О приложении
                NavigationLink {
                    AboutView()
                } label: {
                    SettingsRowView(
                        title: "О приложении",
                        subtitle: "Версия, автор, цели проекта",
                        systemImage: "info.circle"
                    )
                    .padding(.vertical, 10)
                    .padding(.horizontal, 12)
                }
                
                Divider().padding(.leading, 52)
                
                // Контакты
                NavigationLink {
                    ContactsView()
                } label: {
                    SettingsRowView(
                        title: "Контакты города",
                        subtitle: "Акимат, ЕДС, экстренные службы",
                        systemImage: "phone.arrow.up.right"
                    )
                    .padding(.vertical, 10)
                    .padding(.horizontal, 12)
                }
                
                Divider().padding(.leading, 52)
                
                // Уведомления
                SettingsToggleRowView(
                    title: "Уведомления",
                    subtitle: "Новости, статусы заявок и записи",
                    systemImage: "bell.badge",
                    isOn: .constant(true)
                )
                .padding(.vertical, 10)
                .padding(.horizontal, 12)
                
                Divider().padding(.leading, 52)
                
                // Выйти
                Button {
                    isLoggedIn = false
                } label: {
                    HStack {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                            .foregroundColor(.red)
                            .frame(width: 24, height: 24)
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text("profile_logout".loc)
                                .font(.body)
                                .foregroundColor(.red)
                        }
                        
                        Spacer()
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 12)
                }
            }
            // 🔥 Тут вся магия: округление + тень
            .background(Color(.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
            .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 3)
        }
    }
}
