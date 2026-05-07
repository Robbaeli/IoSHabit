import SwiftUI

// Visas när det inte finns några vanor i listan
struct EmptyStateView: View {
    var onAddTapped: () -> Void

    var body: some View {
        VStack(spacing: 24) {
            ZStack {
                Circle()
                    .fill(Color.mint.opacity(0.15))
                    .frame(width: 140, height: 140)

                Circle()
                    .fill(Color.mint.opacity(0.1))
                    .frame(width: 180, height: 180)

                Image(systemName: "leaf.fill")
                    .font(.system(size: 56))
                    .foregroundStyle(.mint)
            }

            VStack(spacing: 8) {
                Text("Inga vanor \u{00E4}nnu")
                    .font(.title2)
                    .fontWeight(.bold)

                Text("Bygg bra rutiner \u{2014} en vana i taget.\nB\u{00F6}rja med att l\u{00E4}gga till din f\u{00F6}rsta!")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }

            Button(action: onAddTapped) {
                Label("L\u{00E4}gg till en vana", systemImage: "plus.circle.fill")
                    .font(.headline)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 12)
            }
            .buttonStyle(.borderedProminent)
            .tint(.mint)
        }
        .padding()
    }
}

#Preview {
    EmptyStateView { }
}
