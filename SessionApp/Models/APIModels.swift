//
//  APIModels.swift
//  SessionApp
//
//  Created by Shawn McLean on 1/21/25.
//

import Foundation

struct BankUser : Codable
{
    let id:Int
    let firstName:String
    let lastName:String
    let number:Int64
    let balance:Int64
}

public func GetFormattedBodyString(body:String) -> NSAttributedString?
{
    
    do{
        let attributedString = try NSMutableAttributedString(data: Data(body.utf8),
                                                      options: [.documentType: NSAttributedString.DocumentType.html,
                                                                .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        
        
        //  Remove hyperlinks
        attributedString.enumerateAttribute(NSAttributedString.Key.link, in: NSRange(location: 0, length: attributedString.length), options: []) { (value, range, stop) in
                if let _ = value as? URL {
                    //print("hit: ", range )
                    attributedString.removeAttribute(NSAttributedString.Key.link, range: range)
                }
            }
        
        //  Remove underlines
        attributedString.enumerateAttribute(NSAttributedString.Key.underlineStyle, in: NSRange(location: 0, length: attributedString.length), options: []) { (value, range, stop) in
                
                    //print("hit: ", range )
                    attributedString.removeAttribute(NSAttributedString.Key.underlineStyle, range: range)
                
            }
        
        //  remove strike colors
        attributedString.enumerateAttribute(NSAttributedString.Key.strokeColor, in: NSRange(location: 0, length: attributedString.length), options: []) { (value, range, stop) in
                
                    //print("hit: ", range )
            attributedString.removeAttribute(NSAttributedString.Key.strokeColor, range: range)
                
            }
        
        //  remove blue forground color
        attributedString.enumerateAttribute(NSAttributedString.Key.foregroundColor, in: NSRange(location: 0, length: attributedString.length), options: []) { (value, range, stop) in
                
                    //print("hit: ", range )
            attributedString.removeAttribute(NSAttributedString.Key.foregroundColor, range: range)
                
            }
        
        return attributedString
    } catch{
        return nil
    }
}

struct NewsFeed : Codable
{
    let pageNodes:[PageNode]
}

struct PageNode : Codable, Hashable
{
    let title:String
    let topic:String
    let body:String
}

func getExNodes() -> [PageNode]
{
    var res = [PageNode]()
    
    res.append(PageNode(title: "Make Something Out of Your Mental Health Challenges", topic: "https://cdn2.psychologytoday.com/assets/styles/manual_crop_1_1_288x288/public/field_blog_entry_images/2025-02/256px-Charles_Darwin_01.jpg?itok=02idtZFD",
                        body: """
<p><a href="https://www.psychologytoday.com/us/basics/anger" title="Psychology Today looks at Anger" class="basics-link" hreflang="en">Anger</a> is one of the most intense and challenging emotions we experience. It can arise from feelings of injustice, frustration, or perceived threats to our well-being. Whether anger manifests in ourselves or in others, it has the potential to create division, escalate conflicts, and harm relationships. However, anger does not have to control us. By utilizing compassion—specifically, <em>compassionate reframing</em>—we can transform anger into an opportunity for deeper understanding, connection, and positive change.</p>
<div class="markup-replacement-slot markup-replacement-slot-0" data-slot-position="0"></div>
<h2>Understanding Anger and Its Origins</h2>
<p>At its core, anger is a reaction to an appraisal—a mental assessment of a situation that threatens something we value. This appraisal determines the intensity and quality of our emotional response. However, situations themselves do not inherently contain meaning; we assign meaning to them based on our interpretations. When we react in anger, we often view events through a narrow lens, reinforcing negative emotions and rigid perspectives.</p>
<div class="markup-replacement-slot markup-replacement-slot-1" data-slot-position="1"></div>
<p>Reframing is the process of consciously changing our interpretation of an event to reduce negative emotions. People who regularly engage in cognitive reappraisal experience lower levels of <a href="https://www.psychologytoday.com/us/basics/stress" title="Psychology Today looks at stress" class="basics-link" hreflang="en">stress</a>, <a href="https://www.psychologytoday.com/us/basics/depression" title="Psychology Today looks at depression" class="basics-link" hreflang="en">depression</a>, and anger. Compassionate reframing takes this one step further by integrating <em>compassion</em>—for both ourselves and others—into the way we interpret situations. This technique helps us move away from hostility and resentment and toward a mindset of unity and understanding.</p>
<div class="markup-replacement-slot markup-replacement-slot-2" data-slot-position="2"></div>
<h2>The Role of Compassion in Diffusing Anger</h2>
<p>Compassion has the power to neutralize anger by softening our perspective. It allows us to acknowledge suffering—both our own and that of others—without immediate judgment or retaliation. By choosing to see anger as a signal of deeper needs rather than a weapon of destruction, we can shift our reactions from aggressive to constructive.</p>
<div class="markup-replacement-slot markup-replacement-slot-3" data-slot-position="3"></div>
<p>Consider a common scenario: You are at a restaurant, and the server has not attended to your table for quite some time. A typical reaction might be:</p>
<p><em>&#34;This is ridiculous! We’ve been waiting forever. The service here is terrible!&#34;</em></p>
<p>This appraisal is rooted in frustration and a sense of entitlement. It assumes negligence and leads to an angry emotional response.</p>
<div class="markup-replacement-slot markup-replacement-slot-4" data-slot-position="4"></div>
<p>A simple cognitive reappraisal might be:</p>
<p><em>&#34;We’ve been waiting for a while, but at least I can enjoy this time with my friends.&#34;</em></p>
<p>This shift in thinking alleviates some frustration, but it does not necessarily foster compassion.</p>
<p>A compassionate reframe might be:</p>
<p><em>&#34;I don’t like how long this is taking, but I know serving tables is difficult. Maybe they’re short-staffed tonight. At least I can enjoy my time with friends.&#34;</em></p>
<div class="markup-replacement-slot markup-replacement-slot-5" data-slot-position="5"></div>
<p>This approach acknowledges personal discomfort while also extending understanding to the server. It prevents anger from escalating and creates an opportunity to act with patience and kindness.</p>
<h2>Applying Compassionate Reframing to Angry People</h2>
<p>When dealing with someone else&#39;s anger, compassionate reframing can help us de-escalate conflict and engage with the person in a meaningful way. Rather than reacting defensively or dismissively, we can ask ourselves:</p>


<ul>
<li>What might be causing their anger?</li>
<li>Are they experiencing stress, <a href="https://www.psychologytoday.com/us/basics/fear" title="Psychology Today looks at fear" class="basics-link" hreflang="en">fear</a>, or unmet needs?</li>
<li>How can I respond in a way that acknowledges their emotions without fueling hostility?</li>
</ul>
<p>For example, if a colleague lashes out at you for an oversight, an instinctive reaction might be to defend yourself or argue back. However, a compassionate reframe might be:</p>
<div class="markup-replacement-slot markup-replacement-slot-7" data-slot-position="7"></div>
<p><em>&#34;They’re obviously upset, but perhaps this mistake added to their already overwhelming workload. I can acknowledge their frustration without taking their words personally.&#34;</em></p>
<p>This approach maintains personal <a href="https://www.psychologytoday.com/us/basics/boundaries" title="Psychology Today looks at boundaries" class="basics-link" hreflang="en">boundaries</a> while also fostering understanding, reducing the likelihood of an escalating argument.</p>



  
<div class="card-group card-group--condensed card-group--border-bottom d-lg-none">
      <div class="h2 card-group__title">Anger Essential Reads</div>
        <div class="card-group__body">
      

<article data-history-node-id="5031387">
  <div class="media">
          <div class="media--image">
        <a href="/us/blog/in-one-lifespan/202502/understanding-online-aggression">
          
              <img loading="lazy" src="https://cdn2.psychologytoday.com/assets/styles/manual_crop_1_1_75x75/public/teaser_image/blog_entry/2025-02/MarieXMartin.jpg?itok=ylIn34jB" width="75" height="75" alt="" title="MarieXMartinPixabay"/>



      
        </a>
      </div>
        <div class="h3 media--title">
      <a href="/us/blog/in-one-lifespan/202502/understanding-online-aggression" rel="bookmark">Understanding Online Aggression</a>
    </div>
  </div>
</article>


<article data-history-node-id="5029236">
  <div class="media">
          <div class="media--image">
        <a href="/us/blog/the-wisdom-of-anger/202501/harness-the-power-of-anger-for-positive-change">
            <img loading="lazy" src="https://cdn2.psychologytoday.com/assets/styles/manual_crop_1_1_75x75/public/field_blog_entry_images/2025-01/anger%20as%20a%20political%20compass.jpg?itok=KlfiXxqT" width="75" height="75" alt="" title="Image by Author"/>



        </a>
      </div>
        <div class="h3 media--title">
      <a href="/us/blog/the-wisdom-of-anger/202501/harness-the-power-of-anger-for-positive-change" rel="bookmark">Harness the Power of Anger for Positive Change</a>
    </div>
  </div>
</article>

    </div>
  </div>

<h2>Case Study: Nathan’s Road Rage</h2>
<p>Nathan, one of my clients, struggled with anger, particularly in traffic. One morning, another driver cut him off, nearly causing an accident. His immediate reaction was:</p>
<p><em>&#34;You idiot! You could’ve killed us both!&#34;</em></p>
<p>His anger stemmed from a sense of injustice and fear. When he shared this experience in <a href="https://www.psychologytoday.com/us/basics/therapy" title="Psychology Today looks at therapy" class="basics-link" hreflang="en">therapy</a>, I guided him through compassionate reframing by encouraging him to consider alternative explanations:</p>
<div class="markup-replacement-slot markup-replacement-slot-9" data-slot-position="9"></div>
<ul>
<li><em>Perhaps the other driver was rushing to a hospital emergency.</em></li>
<li><em>Maybe they misjudged the distance due to poor visibility.</em></li>
<li><em>Could they have simply made an honest mistake?</em></li>
</ul>
<p>Nathan’s reframe became:</p>
<p><em>&#34;That was a dangerous situation, and I was scared. But I’ll never know why that driver acted that way. I’m <a href="https://www.psychologytoday.com/us/basics/gratitude" title="Psychology Today looks at grateful" class="basics-link" hreflang="en">grateful</a> I’m safe.&#34;</em></p>
<div class="markup-replacement-slot markup-replacement-slot-10" data-slot-position="10"></div>
<p>By shifting his perspective, Nathan diffused his own anger and avoided unnecessary stress. Over time, he applied compassionate reframing to other situations in his life, leading to greater emotional <a href="https://www.psychologytoday.com/us/basics/resilience" title="Psychology Today looks at resilience" class="basics-link" hreflang="en">resilience</a>.</p>
<h2>Practicing Compassionate Reframing</h2>
<p>If you struggle with anger—whether within yourself or in dealing with others—try this compassionate reframing exercise:</p>
<div class="markup-replacement-slot markup-replacement-slot-11" data-slot-position="11"></div>
<ol>
<li>Identify your initial interpretation of the situation. What story are you telling yourself?</li>
<li>Examine your assumptions. Are they harsh, critical, or one-sided?</li>
<li>Determine which of your core needs (security, esteem, autonomy, integrity) have been triggered.</li>
<li>Consider alternative explanations for the situation.</li>
<li>Acknowledge your own emotions with kindness rather than self-judgment.</li>
<li>Extend compassion to the other person by recognizing their possible struggles.</li>
<li>Create a new, more compassionate narrative.</li>
</ol>
<div class="markup-replacement-slot markup-replacement-slot-12" data-slot-position="12"></div>
<p>After completing this exercise, notice how your emotional state shifts. Do you feel calmer? More open? More in control of your response?</p>
<h2>Final Thoughts</h2>
<p>Anger is an unavoidable part of life, but it does not have to dominate our reactions or relationships. By practicing compassionate reframing, we gain the ability to step back, assess situations with kindness, and respond in ways that promote peace rather than conflict. Whether in personal interactions, professional settings, or moments of frustration with strangers, compassionate reframing offers a powerful tool for transforming anger into understanding. The choice to reframe our perspective not only benefits our emotional well-being but also fosters a world where compassion leads the way in conflict resolution and human connection.</p>
<div class="markup-replacement-slot markup-replacement-slot-last" data-slot-position="last"></div>
            
Title editing:  
            Observable Behavior: The Essential Key to Assessing Student Learning
          
Visiting https://www.psychologytoday.com/us/blog/how-we-learn/202503/observable-behavior-the-essential-key-to-assessing-student-learning
body url:  https://www.psychologytoday.com/us/blog/how-we-learn/202503/observable-behavior-the-essential-key-to-assessing-student-learning
body html:  
                    
<div class="markup-replacement-slot markup-replacement-slot-0" data-slot-position="0"></div>
<h2>The Problem With Internal Constructs</h2>
<p>In traditional <a href="https://www.psychologytoday.com/us/basics/education" title="Psychology Today looks at education" class="basics-link" hreflang="en">education</a> practices, it has become common for educators to discuss student engagement, intentions, motivations, or understanding as critical factors in the learning process. Yet, none of these internal constructs can be directly observed or measured because they reside within the student&#39;s mind. Terms such as student engagement, <a href="https://www.psychologytoday.com/us/basics/motivation" title="Psychology Today looks at motivation" class="basics-link" hreflang="en">motivation</a>, or even “deep learning” frequently appear in conversations about assessment, but these concepts inevitably remain ambiguous unless defined through actions. If faculty rely on inferring rather than observing, they risk misinterpreting student competence and skill attainment, allowing subjective interpretations to overshadow evidence-based practice. Assessment becomes guesswork rather than precise documentation of learning.</p>
<div class="markup-replacement-slot markup-replacement-slot-1" data-slot-position="1"></div>
<h2>Observable Behavior as Objective Evidence</h2>
<p>For example, consider a student who consistently participates in discussions and appears attentive. A faculty member might assume this student is deeply engaged and has attained the intended competencies. However, without observable evidence, such as the ability to analyze a concept in writing, solve a relevant problem, or effectively demonstrate skills in a measurable format, these assumptions are speculative at best. Observations of behavior, such as clearly articulated arguments, completed assignments, correct application of techniques, or effective problem-solving skills, are the only reliable metrics for measuring student learning.</p>
<div class="markup-replacement-slot markup-replacement-slot-2" data-slot-position="2"></div>
<p>Similarly, consider a student who appears disinterested or rarely speaks during class sessions. Without observable evidence, faculty might conclude this student is unengaged or lacks understanding. However, unless this student&#39;s skill is explicitly assessed through observable behavior, such as a clearly articulated written response, a correctly solved problem, or a successfully completed project, faculty cannot accurately gauge the student&#39;s competency. Observable behavior serves as an objective anchor, eliminating assumptions about internal states or intentions.</p>
<div class="markup-replacement-slot markup-replacement-slot-3" data-slot-position="3"></div>
<h2>Behaviorism and Educational Assessment</h2>
<p>This reliance on observable behavior aligns strongly with frameworks such as Bloom’s Taxonomy, where clearly defined verbs (analyze, demonstrate, apply, evaluate) articulate what students should be able to perform after instruction. By setting explicit expectations in behavioral terms, faculty remove ambiguity from assessments. Students know exactly what behaviors demonstrate mastery, and faculty have tangible evidence to assess learning effectively.</p>
<div class="markup-replacement-slot markup-replacement-slot-4" data-slot-position="4"></div>
<p>The significance of observable behavior in assessment extends to theoretical justifications as well. <a href="https://www.psychologytoday.com/us/basics/behaviorism" title="Psychology Today looks at B.F. Skinner" class="basics-link" hreflang="en">B.F. Skinner</a>, whose work heavily influenced modern educational psychology, argued convincingly that behaviors, not thoughts or intentions, should form the core of assessment. In his work <em>About Behaviorism,</em> Skinner discusses the translation of mental terminology into observable behavior, stating that when mental terms cannot be eliminated, they can be &#34;translated into behavior&#34; (Skinner, 1974, p. 18).</p>
<div class="markup-replacement-slot markup-replacement-slot-5" data-slot-position="5"></div>
<p>This perspective underscores the necessity of focusing on observable behaviors in educational assessment, as internal states like intentions or feelings are not directly measurable and are always subjective. Similarly, John B. Watson, a pioneer of behaviorism, argued that psychology should be based strictly on observable behavior: &#34;Psychology as the behaviorist views it is a purely objective experimental branch of natural science. Its theoretical goal is the prediction and control of behavior&#34; (Watson, 1913, p. 158).</p>


<h2>Implementing Observable Behavior in Higher Education</h2>
<p>Yet, higher education has historically been reluctant to accept that learning can and must be defined through observable behaviors. Some educators insist on incorporating subjective judgments of student engagement, attitudes, or inferred understanding into assessments. While these internal states may influence behavior, they themselves cannot be assessed directly. Faculty who prioritize observable behavior recognize that regardless of a student&#39;s internal state, learning can only be confirmed through explicit demonstration.</p>
<div class="markup-replacement-slot markup-replacement-slot-7" data-slot-position="7"></div>
<p>This perspective fundamentally shifts responsibility to clearly define, observe, and document student performance. Assessment rubrics, therefore, become an essential tool because they outline precisely what observable behavior represents competency in each skill area. Rubrics offer transparency for both students and faculty, eliminating guesswork and creating fairness and clarity. Students understand exactly what observable actions demonstrate learning, empowering them to control their own performance outcomes.</p>



  
<div class="card-group card-group--condensed card-group--border-bottom d-lg-none">
      <div class="h2 card-group__title">Education Essential Reads</div>
        <div class="card-group__body">
      

<article data-history-node-id="5031340">
  <div class="media">
          <div class="media--image">
        <a href="/us/blog/when-words-fail-us/202502/a-simple-strategy-to-reduce-academic-anxiety-in-dyslexia">
          
              <img loading="lazy" src="https://cdn2.psychologytoday.com/assets/styles/manual_crop_1_1_75x75/public/teaser_image/blog_entry/2025-02/shutterstock_2111421560.jpg?itok=wVQiNzey" width="75" height="75" alt="" title="fizkes/Shutterstock"/>



      
        </a>
      </div>
        <div class="h3 media--title">
      <a href="/us/blog/when-words-fail-us/202502/a-simple-strategy-to-reduce-academic-anxiety-in-dyslexia" rel="bookmark">A Simple Strategy to Reduce Academic Anxiety in Dyslexia</a>
    </div>
  </div>
</article>


<article data-history-node-id="5031303">
  <div class="media">
          <div class="media--image">
        <a href="/us/blog/ulterior-motives/202502/many-people-avoid-studying-properly">
          
              <img loading="lazy" src="https://cdn2.psychologytoday.com/assets/styles/manual_crop_1_1_75x75/public/teaser_image/blog_entry/2025-02/Student%20Studying.jpg?itok=nJpwQlBg" width="75" height="75" alt="" title="Image generated with AI on February 26, 2025"/>



      
        </a>
      </div>
        <div class="h3 media--title">
      <a href="/us/blog/ulterior-motives/202502/many-people-avoid-studying-properly" rel="bookmark">Many People Avoid Studying Properly</a>
    </div>
  </div>
</article>

    </div>
  </div>

<h2>Observable Behavior and Equity</h2>
<p>Moreover, placing observable behavior at the center of assessment ensures equity. Rather than assuming skills or knowledge based on subjective criteria or inferred states like enthusiasm, prior experiences, or attitudes, observable behaviors establish objective standards that every student can aim to meet. Assessing learning through observable behavior alone respects the diversity of learners, as faculty assess the outcome of learning—the skill demonstrated—rather than guessing about how or why that outcome was achieved.</p>
<div class="markup-replacement-slot markup-replacement-slot-9" data-slot-position="9"></div>
<p>Ultimately, focusing exclusively on observable behavior shifts the educational narrative. For example, rather than assuming a student&#39;s competence based on perceived enthusiasm, faculty can evaluate a student&#39;s ability through observable tasks like successfully completing a laboratory experiment, clearly explaining a historical event, or correctly solving a mathematical problem. Faculty no longer rely on vague notions of student engagement or inferred understanding, which often lead to misconceptions and inequity. Instead, faculty document and assess precisely what students do. Observable behaviors provide concrete evidence of skill attainment and competence, aligning assessment directly with instructional objectives.</p>
<div class="markup-replacement-slot markup-replacement-slot-10" data-slot-position="10"></div>
<h2>Assessing Student Learning in the Age of AI</h2>
<p>Behaviorism&#39;s focus on observable behaviors offers a critical advantage for faculty assessing student learning considering that <a href="https://www.psychologytoday.com/us/basics/artificial-intelligence" title="Psychology Today looks at AI" class="basics-link" hreflang="en">AI</a> is becoming commonplace. AI technologies facilitate tasks traditionally measured by grades or tests, such as providing correct answers or generating essays, making these proxies increasingly unreliable indicators of learning as understood by observable skill and competency attainment. By adopting a behaviorist approach, faculty explicitly define and assess skills and competencies that students must demonstrate through observable, authentic behaviors, such as problem-solving in real-world scenarios, <a href="https://www.psychologytoday.com/us/basics/teamwork" title="Psychology Today looks at collaboration" class="basics-link" hreflang="en">collaboration</a> on projects, or effective communication in multimedia formats. This approach encourages the integration of AI as a supportive tool rather than a substitute for learning, emphasizing demonstrable skill mastery and enabling clearer, more equitable assessment of student capabilities.</p>
<div class="markup-replacement-slot markup-replacement-slot-last" data-slot-position="last"></div>
"""
                       
                       ))
    /*
    res.append(PageNode(title: "Kinky Eyes Wide Open in the Film Babygirl", topic:
"https://cdn2.psychologytoday.com/assets/styles/manual_crop_1_1_288x288/public/teaser_image/blog_entry/2025-02/iStock-Fetishiism.jpg?itok=qEb2SdDn",
                        body: """
<html>
<body>
<h1>Hello, world!</h1>
</body>
</html>
"""))
    */
    return res
}

func getPageNodes() async throws -> [PageNode]
{
    let endpoint = "http://144.126.221.170:3000/newsfeed"
    //let endpoint = "http://localhost:3000/newsfeed"
    //print("HereAPI1")
    guard let url = URL(string:endpoint) else{
        print("URLError")
        throw APIError.invalidURL
    }
    
    print("HereAPI2")
    
    let (data, response) = try await URLSession.shared.data(from: url)
    
    print("HereAPI3")
    
    if let responseString = String(data: data, encoding: .utf8) {
            //print("Response Data: \n\(responseString)")
    } else {
        print("Failed to convert data to string.")
    }
    
    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
        throw APIError.invalidResponse
    }
    
    //print("HereAPI4")
    
    do {
        let decoder = JSONDecoder()
        //print("hereAPI55555")
        let res:[PageNode] = try decoder.decode([PageNode].self, from:data)
        //print("hereAPI6:")//, res.firstName)
        return res
    }   catch let jsonError as NSError {
        //print("really?")
        print("JSON decode failed: \(jsonError)")
        throw APIError.invalidData
    }
}

func getBankUser() async throws -> BankUser
{
    let endpoint = "http://localhost:3000/account"
    print("HereAPI1")
    guard let url = URL(string:endpoint) else{
        print("URLError")
        throw APIError.invalidURL
    }
    
    print("HereAPI2")
    
    let (data, response) = try await URLSession.shared.data(from: url)
    
    if let responseString = String(data: data, encoding: .utf8) {
            print("Response Data: \n\(responseString)")
    } else {
        print("Failed to convert data to string.")
    }
    
    print("HereAPI3")
    
    var newres = response as? HTTPURLResponse
    
    if(newres != nil)
    {
        if let code = newres?.statusCode
        {
            print("good cast: ", code)
        }
    }
    
    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
        print("Response New problems")
        throw APIError.invalidResponse
    }
    
    print("HereAPI4")
    
    do {
        let decoder = JSONDecoder()
        print("hereAPI5")
        let res:BankUser = try decoder.decode(BankUser.self, from:data)
        print("hereAPI6:", res.firstName)
        return res
    }   catch {
        throw APIError.invalidData
    }
}

enum APIError:Error{
    case invalidURL
    case invalidResponse
    case invalidData
}
