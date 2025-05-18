//
//  TransactionRowView.swift
//  Dinero
//
//  Created by Vinicius on 5/14/25.
//

import SwiftUI

struct TransactionRowView: View {
    var transaction: TransactionModel
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text(transaction.merchant)
                    .font(.subheadline)
                    .bold()
                    .lineLimit(1)
                
                Text(transaction.category)
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .lineLimit(1)
                
                Text(Date(), format: .dateTime.year().month().day())
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
            }
        }
    }
}

#Preview {
    return Group {
        TransactionRowView(transaction: transactionPreviewData )
    }
    
}
