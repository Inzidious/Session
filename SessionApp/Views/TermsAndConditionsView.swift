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
                        SectionView(
                            title: "3. ACCURACY, COMPLETENESS AND COMPLETNESS OF INFORMATION" ,
                            content:"""
                            We are not responsible if information made available on this site is not accurate, complete, or current. The material on this site is provided for general information only and should not be relied upon or used as the sole basis for making decisions without consulting primary, more accurate, more complete, or more timely sources of information. Any reliance on the material on this site is at your own risk.

                            This site may contain certain historical information. Historical information, necessarily, is not current and is provided for your reference only. We reserve the right to modify the contents of this site at any time, but we have no obligation to update any information on our site. You agree that it is your responsibility to monitor changes to our site.
                            """
                        )
                        SectionView(
                            title: "4. MODIFICATIONS TO THE SERVICE AND PRICES",
                            content: """
                            Prices for our products are subject to change without notice. We reserve the right to modify or discontinue the Services (or any part or content thereof) without notice at any time.
                            
                            We will not be liable to you or to any third-party for any modification, price change, suspension, or discontinuance of the Service.
                            """
                        )
                        
                        SectionView(
                            title: "5. PRODUCTS OR SERVICES",
                            content: """
                            Certain products or Services may be available exclusively online through the website. These products or Services may have limited quantities.  All sales are final.
                            
                            We reserve the right, but are not obligated, to limit the sales of our products or Services to any person, geographic region, or jurisdiction. We may exercise this right on a case-by-case basis. All descriptions of products or product pricing are subject to change at any time without notice, at the sole discretion of us. We reserve the right to discontinue any product at any time. Any offer for any product or service made on this site is void where prohibited.
                            
                            We do not warrant that the quality of any products, Services, information, or other material purchased or obtained by you will meet your expectations, or that any errors in the Service will be corrected.
                            """
                        )
                        
                        SectionView(
                            title: "6. ACCURACY OF BILLING AND ACCOUNT INFORMATION",
                            content: """
                            We reserve the right to refuse any order you place with us. We may, in our sole discretion, limit or cancel quantities purchased per person, per household, or per order. These restrictions may include orders placed by or under the same customer account, the same credit card, and/or orders that use the same billing and/or shipping address. In the event that we make a change to or cancel an order, we may attempt to notify you by contacting the e-mail and/or billing address/phone number provided at the time the order was made. We reserve the right to limit or prohibit orders that, in our sole judgment, appear to be placed by dealers, resellers or distributors.
                            
                            You agree to provide current, complete, and accurate purchase and account information for all purchases made on our site. You agree to promptly update your account and other information, including your email address and credit card numbers and expiration dates, so that we can complete your transactions and contact you as needed.
                            """
                        )
                        
                        SectionView(
                            title: "7. OPTIONAL TOOLS",
                            content: """
                            We may provide you with access to third-party tools over which we neither monitor nor have any control nor input. You acknowledge and agree that we provide access to such tools "as is" and "as available" without any warranties, representations or conditions of any kind and without any endorsement. We shall have no liability whatsoever arising from or relating to your use of optional third-party tools. Any use by you of the optional tools offered through the site is entirely at your own risk and discretion and you should ensure that you are familiar with and approve of the terms on which tools are provided by the relevant third-party provider(s).
                            
                            We may also, in the future, offer new Services and/or features through the website (including, the release of new tools and resources). Such new features and/or Services will be subject to these Terms of Service.
                            """
                        )
                    }
                    
                    Group {
                        SectionView(
                            title: "8. THIRD-PARTY LINKS",
                            content: """
                            Certain content, products and Services available via our Service may include materials from third-parties. Third-party links on this site may direct you to third-party websites that are not affiliated with us. We are not responsible for examining or evaluating the content or accuracy and we do not warrant and will not have any liability or responsibility for any third-party materials or websites, or for any other materials, products, or Services of third-parties.
                            
                            We are not liable for any harm or damages related to the purchase or use of goods, Services, resources, content, or any other transactions made in connection with any third-party websites. Please review carefully the third-party's policies and practices and make sure you understand them before you transact. Complaints, claims, concerns, or questions regarding third-party products should be directed to the third-party.
                            """
                        )
                    }
                    
                    Group {
                        SectionView(
                            title: "9. USER COMMENTS, FEEDBACK, GRANT, AND CONDITIONS",
                            content: """
                            If you choose to provide feedback including any ideas, suggestions, concepts, processes, techniques, questions, answers, codes/scripts, and other comments related to our Services, site, proposed services, documentation or business ("Feedback"), we will own and may use such Feedback without any restrictions and obligations to you, and you hereby waive any claim you have to ownership, compensation, monetary or otherwise.
                            
                            You grant us a non-exclusive right to use your trade-names, trademarks, service marks, trade dress and logos to promote our Service.
                            
                            We may, but have no obligation to, monitor, edit or remove content that we determine in our sole discretion to be unlawful, offensive, threatening, libelous, defamatory, pornographic, obscene or otherwise objectionable or violates any party's intellectual property or these Terms of Service.
                            
                            You agree that your comments will not violate any right of any third-party, including copyright, trademark, privacy, personality or other personal or proprietary right. You further agree that your comments will not contain libelous or otherwise unlawful, abusive, or obscene material, or contain any computer virus or other malware that could in any way affect the operation of the Service or any related website. You may not use a false e-mail address, pretend to be someone other than yourself, or otherwise mislead us or third-parties as to the origin of any comments. You are solely responsible for any comments you make and their accuracy. We take no responsibility and assume no liability for any comments posted by you or any third-party.
                            """
                        )
                    }
                    
                    Group {
                        SectionView(
                            title: "10. PERSONAL INFORMATION",
                            content: """
                            Your submission of personal information through the store is governed by our Privacy Policy. To view, please see our privacy policy here.
                            """
                        )
                    }
                    
                    Group {
                        SectionView(
                            title: "11. ERRORS, INACCURACIES AND OMISSIONS",
                            content: """
                            Occasionally there may be information on our site or in the Service that contains typographical errors, inaccuracies or omissions that may relate to product descriptions, pricing, promotions, offers, product shipping charges, transit times and availability. We reserve the right to correct any errors, inaccuracies, or omissions, and to change or update information or cancel orders if any information in the Service or on any related website is inaccurate at any time without prior notice (including after you have submitted your order).
                            
                            We undertake no obligation to update, amend or clarify information in the Service or on any related website, including without limitation, pricing information, except as required by law. No specified update or refresh date applied in the Service or on any related website, should be taken to indicate that all information in the Service or on any related website has been modified or updated.
                            """
                        )
                    }
                    
                    Group {
                        SectionView(
                            title: "12. PROHIBITED USES",
                            content: """
                            In addition to other prohibitions as set forth in the Terms of Service, following general conditions apply to your use of the Services:
                            
                            You are responsible for your conduct and activity when using our website. You must ensure that you do not, either directly or indirectly:
                            use the Services for or in connection with any illegal or unauthorized purpose or in a manner that: (a) infringes, violates or misappropriates any rights of any person, including intellectual property, confidentiality or privacy rights, (b) is harmful, fraudulent, deceptive, misleading, threatening, harassing, defamatory, offensive, biased, obscene, vulgar, indecent, menacing, tortious or otherwise objectionable as determined by us in our sole discretion, (c) attempts, in any manner, to obtain the password, account, or other security information from any other user, (d) violates the security of any computer network, or crack any passwords or security encryption codes, (e) submit false or misleading information or (e) violates any laws, rules or regulations in your jurisdiction (including but not limited to copyright, data protection and privacy laws) as well as the laws of Canada;
                            reverse engineer, decompile, disassemble, decrypt or otherwise attempt to discover the code or underlying structure, ideas, know-how or algorithms relevant to the Services or access the Services, or write or develop any program based on the Services or any portion thereof, in order to build a similar or competitive product or service or copy any ideas, features, functions, or graphics of the Services;
                            circumvent or attempt to circumvent any limitations imposed on your account including any license, timing or use restrictions that are built into the Services;
                            lend, sell, resell, lease, sublicense, transfer, assign, distribute, grant a security interest in, or otherwise use the Services for the benefit of a third party, unless we have given you prior written authorization;
                            modify, translate, or create derivative works based on the Services or any software, hardware, documentation or data related to the Services, in whole or part, or reproduce, duplicate, copy, or exploit any portion of the Services in whole or in part except to the extent expressly permitted in writing by Thinkific or authorized within the Services;
                            upload, transmit, disseminate or use the Services to send or store malicious code, including any worms, viruses, Trojan horses, or any other software or code of a destructive nature;
                            use the Services to collect or store any sensitive information ("Sensitive Information") including, but not limited to personal health information, banking and credit card information, and if you do use the Service to collect, store or otherwise process any Sensitive Information you do so at your own risk and you are responsible for ensuring compliance with all applicable laws;
                            use the Services other than in accordance with our product documentation;
                            permit the Services to be used by anyone other than yourself; 
                            use the bandwidth and storage resources provided by us in an unreasonable and disproportionate manner. We monitor usage to ensure fair distribution of resources among all of our customers. In the event that your bandwidth or storage usage exceeds what we view in our sole discretion is reasonable and proportionate, we reserve the right to take appropriate measures, including but not limited to implementing bandwidth throttling, imposing storage limits, suspending or terminating your access to the services, in whole or in part, without liability;
                            circumvent or otherwise interfere with any authentication or security measures of the Services, or otherwise interfere with or disrupt the integrity or performance of the Services, including doing anything to, or using the Services in a way that may, cause the Services to be interrupted, damaged, rendered less efficient or such that the effectiveness or functionality of the Services is in any way impaired, including overloading, flooding, spamming, mailbombing or crashing; and
                            use any robot, spider, device, technology or process to monitor or copy any data or pages within the Services without our prior written consent.
                            
                            We reserve the right to terminate your use of the Service or any related website for violating any of the prohibited uses.
                            """
                        )
                    }
                    
                    Group {
                        SectionView(
                            title: "13. DISCLAIMER OF WARRANTIES; LIMITATION OF LIABILITY",
                            content: """
                            We do not guarantee, represent, or warrant that your use of our service will be uninterrupted, timely, secure or error-free. We do not warrant that the results that may be obtained from the use of the service will be accurate or reliable.

                            You agree that from time to time we may remove the service for indefinite periods of time or cancel the service at any time, without notice to you.

                            You expressly agree that your use of, or inability to use, the service is at your sole risk. The service and all products and Services delivered to you through the service are (except as expressly stated by us) provided 'as is' and 'as available' for your use, without any representation, warranties, or conditions of any kind, either express or implied, including all implied warranties or conditions of merchantability, merchantable quality, fitness for a particular purpose, durability, title, and non-infringement.

                            In no case shall Therapy Muse LLC, our directors, officers, employees, affiliates, agents, contractors, interns, suppliers, service providers or licensors be liable for any injury, loss, claim, or any direct, indirect, incidental, punitive, special, or consequential damages of any kind, including, without limitation lost profits, lost revenue, lost savings, loss of data, replacement costs, or any similar damages, whether based in contract, tort (including negligence), strict liability or otherwise, arising from your use of any of the service or any products procured using the service, or for any other claim related in any way to your use of the service or any product, including, but not limited to, any errors or omissions in any content, or any loss or damage of any kind incurred as a result of the use of the service or any content (or product) posted, transmitted, or otherwise made available via the service, even if advised of their possibility.

                            Because some states or jurisdictions do not allow the exclusion or the limitation of liability for consequential or incidental damages, in such states or jurisdictions, our liability shall be limited to the maximum extent permitted by law.
                            """
                        )
                    }
                    
                    Group {
                        SectionView(
                            title: "14. INDEMNIFICATION",
                            content: """
                            You agree to indemnify, defend and hold harmless Therapy Muse LLC and our parent, subsidiaries, affiliates, partners, officers, directors, agents, contractors, licensors, service providers, subcontractors, suppliers, interns and employees, harmless from any claim or demand, including reasonable attorneys' fees, made by any third-party due to or arising out of your breach of these Terms of Service or the documents they incorporate by reference, or your violation of any law or the rights of a third-party.
                            """
                        )
                    }
                    
                    Group {
                        SectionView(
                            title: "15. SEVERABILITY",
                            content: """
                            In the event that any provision of these Terms of Service is determined to be unlawful, void or unenforceable, such provision will nonetheless be enforceable to the fullest extent permitted by applicable law, and the unenforceable portion shall be deemed to be severed from these Terms of Service, such determination shall not affect the validity and enforceability of any other remaining provisions.
                            """
                        )
                    }
                    
                    Group {
                        SectionView(
                            title: "16. TERMINATION",
                            content: """
                            The obligations and liabilities of the parties incurred prior to the termination date will survive the termination of this agreement for all purposes.

                            These Terms of Service are effective unless and until terminated by either you or us. You may terminate these Terms of Service at any time by notifying us that you no longer wish to use our Services, or when you cease using our site.

                            If in our sole judgment you fail, or we suspect that you have failed, to comply with any term or provision of these Terms of Service, we also may terminate this agreement at any time without notice and you will remain liable for all amounts due up to and including the date of termination; and/or accordingly may deny you access to our Services (or any part thereof).
                            """
                        )
                    }
                }
                
                Group {
                    SectionView(
                        title: "17. ENTIRE AGREEMENT",
                        content: """
                        The failure of us to exercise or enforce any right or provision of these Terms of Service does not constitute a waiver of such right or provision.

                        These Terms of Service and any policies or operating rules posted by us on this site or in respect to The Service constitutes the entire agreement and understanding between you and us and govern your use of the Service, superseding any prior or contemporaneous agreements, communications, and proposals, whether oral or written, between you and us (including, but not limited to, any prior versions of the Terms of Service).

                        Any ambiguities in the interpretation of these Terms of Service shall not be construed against the drafting party.
                        """
                    )
                }
                
                Group {
                    SectionView(
                        title: "18. GOVERNING LAW",
                        content: """
                        These Terms of Service and any separate agreements whereby we provide you Services shall be governed by and construed in accordance with the laws of the state of California.
                        """
                    )
                }
                
                Group {
                    SectionView(
                        title: "19. CHANGES TO TERMS OF SERVICE",
                        content: """
                        None
                        """
                    )
                }
                
                Group {
                    SectionView(
                        title: "20. CONTACT INFORMATION",
                        content: """
                        Questions about the Terms of Service should be sent to us at info@mytherapymuse.com.

                        Our contact information is posted below:
                        3120 Telegraph Ave. Berkeley, CA 94705
                        """
                    )
                }
                
                Group {
                    SectionView(
                        title: "21. NO REFUND CLAUSE",
                        content: """
                        We do not offer refunds for any products or services purchased through our website unless explicitly stated otherwise. All sales are final.
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

#Preview {
    TermsAndConditionsView()
} 
