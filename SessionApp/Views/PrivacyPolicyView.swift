import SwiftUI

struct PrivacyPolicyView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Overview Section
                    Group {
                        SectionView(
                            title: "1. What information do we collect and what do we do with it?",
                            content: """
                            When you subscribe to our site to receive free or paid products, including online courses, eBooks and webinars, we collect the personal information you give us such as your name and email address. Additionally, we collect device-specific information such as your operating system version and device type to enhance your app experience.
                            Email marketing: we may send you emails about our site, related services, products or other updates. We may also use your email to inform you about new products, services, changes to products, survey you about your usage, or seek your opinion.
                            Your personal information is strictly confidential and will never be sold, rented, or otherwise disclosed to any third party.
                            """
                        )
                        
                        SectionView(
                            title: "2. How do you get my consent?",
                            content: """
                            When you provide us with personal information to subscribe to a service on our site, make a purchase, or participate in or consume a digital product, you imply that you consent to our collecting it and using it for that specific reason only.
                            If we ask for your personal information for a secondary reason, like marketing, we will either ask you directly for your expressed consent, or provide you with an opportunity to unsubscribe if consent is implied.
                            """
                        )
                        SectionView(
                            title: "3. How do I withdraw my consent?" ,
                            content:"""
                            If after you opt-in, you change your mind, you may withdraw your consent at anytime, by contacting us at info@mytherapymuse.com.
                            """
                        )
                        SectionView(
                            title: "4. Disclosure",
                            content: """
                            We may disclose your personal information if we are required by law, such as in response to a court order or an investigation.
                            """
                        )
                        
                        SectionView(
                            title: "5. Payment",
                            content: """
                            If you make a purchase on our site, we use a third-party payment processor such as Stripe or PayPal. Payments are encrypted through the Payment Card Industry Data Security Standard (PCI-DSS). Your purchase transaction data is stored only as long as is necessary to complete your purchase transaction.
                            All direct payment gateways adhere to the standards set by PCI-DSS as managed by the PCI Security Standards Council, which is a joint effort of brands like Visa, MasterCard, American Express and Discover.
                            PCI-DSS requirements help ensure the secure handling of credit card information by our site and related courses and its service providers.
                            """
                        )
                        
                        SectionView(
                            title: "6. Third-Party Services",
                            content: """
                            In general, the third-party providers used by us will only collect, use and disclose your information to the extent necessary to allow them to perform the services they provide to us.
                            However, certain third-party service providers, such as payment gateways and other payment transaction processors, have their own privacy policies in respect to the information we are required to provide to them for your purchase-related transactions.
                            For these providers, we recommend that you read their privacy policies so you can understand the manner in which your personal information will be handled by these providers.
                            Certain providers may be located in or have facilities that are located in a different jurisdiction than either you or us. If you elect to proceed with a transaction that involves the services of a third-party service provider, then your information may become subject to the laws of the jurisdiction(s) in which that service provider or its facilities are located.
                            As an example, if you are located in Canada and your transaction is processed by a payment gateway located in the United States, then your personal information used in completing that transaction may be subject to disclosure under United States legislation, including the Patriot Act.
                            Once you leave our website or are redirected to a third-party website or application, you are no longer governed by this Privacy Policy or our website's Terms of Service.
                            """
                        )
                        
                        SectionView(
                            title: "7. Links",
                            content: """
                            When you click on links on our site, they may direct you away from our site. We are not responsible for the privacy practices of other sites and encourage you to read their privacy statements.
                            """
                        )
                    }
                    
                    Group {
                        SectionView(
                            title: "8. Security",
                            content: """
                            To protect your personal information, we take reasonable precautions and follow industry best practices to make sure it is not inappropriately lost, misused, accessed, disclosed, altered, or destroyed.
                            If you provide us with your credit card information, the information is encrypted using secure socket layer technology (SSL) and stored with AES-256 encryption.  Although no method of transmission over the Internet or electronic storage is 100% secure, we follow all PCI-DSS requirements and implement additional generally accepted industry standards.
                            """
                        )
                    }
                    
                    Group {
                        SectionView(
                            title: "9. Cookies",
                            content: """
                            We collect cookies or similar tracking technologies. This means information that our website's server transfers to your computer. This information can be used to track your session on our website. Cookies may also be used to customize our website content for you as an individual. If you are using one of the common Internet web browsers, you can set up your browser to either let you know when you receive a cookie or to deny cookie access to your computer.
                            We uses cookies to recognize your device and provide you with a personalized experience. 
                            
                            We may also use automated tracking methods on our websites, in communications with you, and in our products and services, to measure performance and engagement.
                            
                            Please note that because there is no consistent industry understanding of how to respond to "Do Not Track" signals, we do not alter our data collection and usage practices when we detect such a signal from your browser.
                            """
                        )
                    }
                    
                    Group {
                        SectionView(
                            title: "10. Web Analysis Tools",
                            content: """
                            We may use web analysis tools that are built into the website to measure and collect anonymous session information.
                            """
                        )
                    }
                    
                    Group {
                        SectionView(
                            title: "11. Age of Consent",
                            content: """
                            By using this site, you represent that you are at least the age of majority in your state or province of residence, or that you are the age of majority in your state or province of residence and you have given us your consent to allow any of your minor dependents to use this site.
                            """
                        )
                    }
                    
                    Group {
                        SectionView(
                            title: "12. Changes to this Privacy Policy",
                            content: """
                            We reserve the right to modify this privacy policy at any time, so please review it frequently. Changes and clarifications will take effect immediately upon their posting on the website. If we make material changes to this policy, we will notify you here that it has been updated, so that you are aware of what information we collect, how we use it, and under what circumstances, if any, we use and/or disclose it.
                            If our site or course is acquired or merged with another company, your information may be transferred to the new owners so that we may continue to sell products to you.
                            """
                        )
                    }
                    
                    Group {
                        SectionView(
                            title: "13. QUESTIONS AND CONTACT INFORMATION",
                            content: """
                            If you would like to: access, correct, amend or delete any personal information we have about you, register a complaint, or simply want more information contact at info@mytherapymuse.com.
                            """
                        )
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 24)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        HStack {
                            Image(systemName: "arrow.left.circle")
                                .font(.title2)
                                .foregroundStyle(Color(red: 0.8823529412, green: 0.6941176471, blue: 0.4156862745))
                        }
                    }
                    .padding(.leading, 10)
                }
            }
        }
    }
}

#Preview {
    PrivacyPolicyView()
} 
