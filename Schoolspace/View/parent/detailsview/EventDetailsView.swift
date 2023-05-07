//
//  EventDetailsView.swift
//  Schoolspace
//
//  Created by Mohamed Abbes on 6/5/2023.
//

import SwiftUI
import URLImage

struct EventDetailsView: View {
    let eventId: String
    
    @StateObject private var viewModel = EventDetailsViewModel()
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        VStack {
            if let event = viewModel.event {
                EventDetailsHeader(event: event)
                EventDetailsBody(event: event)
            } else {
                ProgressView()
                    .onAppear {
                        viewModel.fetchEventDetails(eventId: eventId)
                    }
            }
        }
        .padding()
        .sheet(isPresented: $viewModel.showSheet) {
         
        }
    }
}

struct EventDetailsHeader: View {
    let event: Event
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
           
            Text(event.name)
                .font(.largeTitle)
                .fontWeight(.bold)
            Text(event.date)
                .foregroundColor(.secondary)
        }
    }
}

struct EventDetailsBody: View {
    let event: Event
    @StateObject private var viewModel = EventDetailsViewModel()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Description Section
                Section {
                    
                    
                    URLImage(URL(string: event.image)!) { proxy in
                        proxy
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .cornerRadius(10)
                            .frame(width: .infinity)
                    }}

                Divider()
                Section {
                    Text("Description")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.bottom, 2)

                    Text(event.description)
                        .foregroundColor(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                        .lineSpacing(6)
                }

                Divider()

                // Location Section
                Section {
                    Text("Location")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.bottom, 2)

                    Text(event.place)
                        .foregroundColor(.secondary)
                }

                Divider()

                // Organizer Section
                Section {
                    Text("Time")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.bottom, 2)
                    Text(event.time)
                        .foregroundColor(.secondary)
                }

               
            }
            .padding(.horizontal)
        }
    }
}

class EventDetailsViewModel: ObservableObject {
    @Published var event: Event?
    @Published var showSheet = false
    
    func fetchEventDetails(eventId: String) {
        let urlString = "http://localhost:8080/event/\(eventId)"
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL: \(urlString)")
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching event details: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                let eventResponse = try JSONDecoder().decode(Event.self, from: data)
                DispatchQueue.main.async {
                    self.event = eventResponse
                }
            } catch {
                print("Error decoding event details: \(error.localizedDescription)")
            }
        }.resume()
    }
}

