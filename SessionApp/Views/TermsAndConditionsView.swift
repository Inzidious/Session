import SwiftUI

struct TermsAndConditionsView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Overview Section
                    Group {
                        Text("Terms and Conditions")
                            .font(.largeTitle)
                            .bold()
                            .padding(.bottom, 8)
                        
                        Text("OVERVIEW")
                            .font(.headline)
                        Text("This website is operated by Therapy Muse LLC Therapy. Throughout the site, the terms we, us and our refer to Therapy Muse LLC. Therapy Muse LLC offers this website, including all information, tools and Services available from this site to you, the user, on your acceptance of all terms, conditions, policies and notices stated herein.")
                            .font(.body)
                            .padding(.bottom, 8)
                        Text("By visiting our site and/or purchasing something from us, you engage in our 'Service(s)' and agree to be bound by the following terms and conditions ('Terms of Service', 'Terms'), including those additional terms and conditions and policies referenced herein and/or available by hyperlink. These Terms of Service apply to all users of the site, including without limitation users who are browsers, vendors, customers, merchants, and/or contributors of content.")
                            .font(.body)
                            .padding(.bottom, 8)
                        Text("Please read these Terms carefully before accessing or using our Services on our website. By accessing our Services or using any part of the site, you agree to be bound by these Terms of Service. If you do not agree to the Terms, then you may not access the website or use our Services. If these Terms of Service are considered an offer, acceptance is expressly limited to these Terms of Service.")
                            .font(.body)
                            .padding(.bottom, 8)
                        Text("Any new features or tools which are added to the current website are subject to the Terms of Service. You can review the most current version of the Terms of Service at any time on this page. We reserve the right to update, change or replace any part of these Terms of Service by posting updates and/or changes to our website. It is your responsibility to check this page periodically for changes. Your continued use of or access to the website following the posting of any changes constitutes your acceptance of those changes.")
                            .font(.body)
                            .padding(.bottom, 8)
                        
                        // Important Notice
                        Text("IMPORTANT NOTICE")
                            .font(.headline)
                        Text("THE INFORMATION PROVIDED ON THIS PLATFORM IS FOR EDUCATIONAL PURPOSES ONLY AND IS NOT INTENDED TO SUBSTITUTE FOR PROFESSIONAL MENTAL HEALTH ADVICE, DIAGNOSIS, OR TREATMENT. ALWAYS SEEK THE GUIDANCE OF A QUALIFIED MENTAL HEALTH PROFESSIONAL REGARDING ANY QUESTIONS OR CONCERNS YOU MAY HAVE ABOUT YOUR INDIVIDUAL SITUATION. BY ACCESSING THIS CONTENT, YOU ACKNOWLEDGE THAT NO THERAPEUTIC RELATIONSHIP IS ESTABLISHED AND YOU ARE SOLELY RESPONSIBLE FOR YOUR OWN DECISIONS RELATED TO YOUR MENTAL HEALTH.YOU AGREE THAT THE PRODUCTS AND SERVICES ARE NOT INTENDED TO BE USED IN A MEDICAL EMERGENCY.")
                            .font(.body)
                            .bold()
                            .padding(.bottom, 8)
                    }
                    
                    // Numbered Sections
                    Group {
                        SectionView(
                            title: "1. WEBSITE TERMS",
                            content: """
                            By agreeing to these Terms of Service, you represent that you are at least the age of majority in your state or province of residence, or that you are the age of majority in your state or province of residence, and you have given us your consent to allow any of your minor dependents to use this site.
                            
                            You may not use our products for any illegal or unauthorized purpose nor may you, in the use of the Service, violate any laws in your jurisdiction (including but not limited to copyright laws).
                            
                            You must not transmit any worms or viruses or any code of a destructive nature.
                            
                            A breach or violation of any of the Terms will result in an immediate termination of your Services.
                            """
                        )
                        
                        SectionView(
                            title: "2. GENERAL CONDITIONS",
                            content: """
                            We reserve the right to refuse service to anyone for any reason at any time.
                            
                            With the exception of credit card information which is always encrypted during transfer over networks, you understand that your content (not including credit card information), may be transferred unencrypted and involve (a) transmissions over various networks; and (b) changes to conform and adapt to technical requirements of connecting networks or devices.
                            
                            You agree not to reproduce, duplicate, copy, sell, resell or exploit any portion of the Service, use of the Service, or access to the Service or any contact on the website through which the service is provided, without express written permission by us.
                            
                            The headings used in this agreement are included for convenience only and will not limit or otherwise affect these Terms.
                            """
                        )
                        
                        SectionView(title: "3. ACCURACY, COMPLETENESS AND TIMELINESS OF INFORMATION", content: "We are not responsible if information made available on this site is not accurate, complete, or current...")
                    }
                    
                    // Continue with more sections...
                    
                    // Contact Information
                    Group {
                        Text("CONTACT INFORMATION")
                            .font(.headline)
                        Text("Questions about the Terms of Service should be sent to us at info@mytherapymuse.com\n\n3120 Telegraph Ave. Berkeley, CA 94705")
                            .font(.body)
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 24)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Close") {
                        dismiss()
                    }
                }
            }
        }
    }
}

// Helper view for sections
struct SectionView: View {
    let title: String
    let content: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
            Text(content)
                .font(.body)
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    TermsAndConditionsView()
} 
