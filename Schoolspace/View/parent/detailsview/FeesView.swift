
import SwiftUI


struct PaymentListView: View {
    let studentId: String
    @State private var fees: [Fee] = []
    @State private var selectedFee: Fee?
    @State private var showPaymentSheet = false
    @State private var dismissPaymentSheet = false

    var body: some View {
        VStack {
            Image("icon_exit")
                .padding(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .onTapGesture(perform: {
                    
                })
            
            
            Text("Paiements fees")
                .padding(.leading) .frame(maxWidth: .infinity, alignment: .leading)
                .fontWeight(.bold)
            
            List(fees) { fee in
                Button(action: {
                    selectedFee = fee
                    showPaymentSheet = true
                }) {
                    HStack {
                        Text("Paiement ID \(fee.id)")
                        Spacer()
                        Text("$\(fee.amount)")
                            .foregroundColor(fee.paid ? .green : .red)
                    }
                
                }
            }
            .background(.white)
        }
        .padding()
        .sheet(item: $selectedFee) { fee in
            PaymentSheetView(fee: fee, dismissSheet: $dismissPaymentSheet)
        }
        .onAppear {
            getFeesByStudent()
        }
    }
    
    func getFeesByStudent() {
        let url = URL(string: "http://localhost:8080/fee/\(studentId)")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let fees = try decoder.decode([Fee].self, from: data)
                    DispatchQueue.main.async {
                        self.fees = fees
                    }
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
}

struct PaymentSheetView: View {
    let fee: Fee
    @State private var isPaid = false
    @Binding var dismissSheet: Bool

    var body: some View {
        VStack {
            Image("icon_exit")
                .padding(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .onTapGesture(perform: {
                    
                })
       
            
            
            Text("Paiements details")
                .padding(.leading) .frame(maxWidth: .infinity, alignment: .leading)
                .fontWeight(.bold)
               
            
            Text("Paiement ID \(fee.id)")
                .padding()
            
            Text("Amount to pay: $\(fee.amount)")
                .padding()
         Spacer()
            
            Button(action: {
               updateFeeToPaid()
            })
                   {
                       // 1
                       Text("Pay the fees")
                           .frame(maxWidth: .infinity)
                           .padding()
                   }
                   .foregroundColor(.white) // 2
                   .background(Color(0xFF016DB1))
                   .cornerRadius(10) // 4
                   .padding()
                   
            }
            .padding()
            .onAppear {
                        isPaid = fee.paid
                    }
                    .onChange(of: isPaid) { value in
                        if value {
                            dismissSheet = true
                        }
                    }
        
    }
    
    
func updateFeeToPaid() {
    let url = URL(string: "http://localhost:8080/fee/\(fee.id)")!
    var request = URLRequest(url: url)
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpMethod = "PUT"
    
    let body = ["paid": true]
    
    let jsonData = try! JSONSerialization.data(withJSONObject: body, options: [])
    
    URLSession.shared.uploadTask(with: request, from: jsonData) { data, response, error in
        if let data = data {
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let updatedFee = try decoder.decode(Fee.self, from: data)
                DispatchQueue.main.async {
                    self.isPaid = updatedFee.paid
                }
            } catch {
                print(error)
            }
        }
    }.resume()
}



}
