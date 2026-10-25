import Link from 'next/link';

export default function BlogSingle() {
  return (
    <>
      <section id="subheader" className="bg-color-op-1 text-center">
        <div className="container relative z-2">
          <div className="row justify-content-center">
            <div className="col-lg-10">
              <h2 className="wow fadeInUp">Discover 10 Easy Tips to Maintain a Healthier and Brighter Smile Today</h2>
              <div className="border-bottom my-3"></div>
              <ul className="crumb wow fadeInDown">
                <li><Link href="/">Home</Link></li>
                <li className="active">Blog</li>
              </ul>
            </div>
          </div>
        </div>
      </section>

      <section>
        <div className="container">
          <div className="row gx-5">
            <div className="col-lg-8">
              <div className="blog-read">
                <div className="post-text">
                  <p>A bright, confident smile isn’t just about looks—it’s a sign of good oral health and self-care. Whether you’re trying to maintain pearly whites or improve your dental routine, small daily habits can make a big difference. Here are 10 easy tips to help you keep your smile healthy and radiant.</p>

                  <img src="/images/misc/l6.webp" className="w-100 mb-4 rounded-1" alt="" />

                  <ol className="ol-style-1">
                    <li><h5>Brush Twice a Day—Properly</h5>
                      Brushing your teeth in the morning and before bed is essential. Use a soft-bristled toothbrush and fluoride toothpaste. Take at least two minutes, making sure to clean all surfaces of your teeth gently but thoroughly.
                    </li>
                    <li><h5>Don’t Forget to Floss</h5>
                      Flossing removes plaque and food particles between teeth that brushing alone can’t reach. Daily flossing helps prevent gum disease and cavities, especially in those hard-to-reach spots.
                    </li>
                    <li><h5>Use Mouthwash for Extra Protection</h5>
                      An antimicrobial or fluoride mouthwash can help reduce plaque, fight bad breath, and strengthen enamel. Use it as a finishing touch to your brushing and flossing routine.
                    </li>
                    <li><h5>Limit Sugary and Acidic Foods</h5>
                      Sugar feeds harmful bacteria in your mouth, while acidic foods and drinks can erode enamel. Reduce consumption of soda, candy, and citrus fruits, and rinse your mouth with water afterward if you do indulge.
                    </li>
                    <li><h5>Stay Hydrated</h5>
                      Drinking plenty of water helps wash away food debris and bacteria. It also promotes saliva production, which naturally protects your teeth and gums.
                    </li>
                    <li><h5>Eat a Tooth-Friendly Diet</h5>
                      Include crunchy fruits and vegetables like apples and carrots, which naturally clean your teeth. Dairy products are rich in calcium and phosphates that help strengthen enamel.
                    </li>
                    <li><h5>Avoid Tobacco Products</h5>
                      Smoking and chewing tobacco stain teeth and increase the risk of gum disease and oral cancer. Quitting is one of the best things you can do for your overall and oral health.
                    </li>
                    <li><h5>Visit Your Dentist Regularly</h5>
                      Don’t skip your biannual dental check-ups. Professional cleanings remove tartar buildup and your dentist can spot early signs of decay or gum disease before they become serious problems.
                    </li>
                    <li><h5>Whiten Safely</h5>
                      If you’re looking for a brighter smile, consult your dentist before using whitening products. Some over-the-counter options can cause sensitivity or damage enamel if not used correctly.
                    </li>
                    <li><h5>Protect Your Teeth</h5>
                      If you grind your teeth at night or play contact sports, use a mouthguard. This protects against unnecessary wear or injury that can affect the look and health of your smile.
                    </li>
                  </ol>
                </div>
              </div>

              <div className="spacer-single"></div>

              <div id="blog-comment">
                <h4>Comments (5)</h4>

                <div className="spacer-half"></div>

                <ol>
                  <li>
                    <div className="avatar">
                      <img src="/images/testimonial/1.webp" alt="" /></div>
                    <div className="comment-info">
                      <span className="c_name">Merrill Rayos</span>
                      <span className="c_date id-color">2 days ago</span>
                      <span className="c_reply"><Link href="#">Reply</Link></span>
                      <div className="clearfix"></div>
                    </div>

                    <div className="comment">Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.</div>
                    <ol>
                      <li>
                        <div className="avatar">
                          <img src="/images/testimonial/2.webp" alt="" /></div>
                        <div className="comment-info">
                          <span className="c_name">Jackqueline Sprang</span>
                          <span className="c_date id-color">2 days ago</span>
                          <span className="c_reply"><Link href="#">Reply</Link></span>
                          <div className="clearfix"></div>
                        </div>
                        <div className="comment">Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt
                          explicabo.</div>
                      </li>
                    </ol>
                  </li>

                  <li>
                    <div className="avatar">
                      <img src="/images/testimonial/3.webp" alt="" /></div>
                    <div className="comment-info">
                      <span className="c_name">Sanford Crowley</span>
                      <span className="c_date id-color">2 days ago</span>
                      <span className="c_reply"><Link href="#">Reply</Link></span>
                      <div className="clearfix"></div>
                    </div>
                    <div className="comment">Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.</div>
                    <ol>
                      <li>
                        <div className="avatar">
                          <img src="/images/testimonial/4.webp" alt="" /></div>
                        <div className="comment-info">
                          <span className="c_name">Lyndon Pocekay</span>
                          <span className="c_date id-color">2 days ago</span>
                          <span className="c_reply"><Link href="#">Reply</Link></span>
                          <div className="clearfix"></div>
                        </div>
                        <div className="comment">Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt
                          explicabo.</div>
                      </li>
                    </ol>
                  </li>

                  <li>
                    <div className="avatar">
                      <img src="/images/testimonial/5.webp" alt="" /></div>
                    <div className="comment-info">
                      <span className="c_name">Aleen Crigger</span>
                      <span className="c_date id-color">2 days ago</span>
                      <span className="c_reply"><Link href="#">Reply</Link></span>

                      <div className="clearfix"></div>
                    </div>
                    <div className="comment">Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.</div>
                  </li>
                </ol>

                <div className="spacer-single"></div>

                <div id="comment-form-wrapper">
                  <h4>Leave a Comment</h4>
                  <div className="comment_form_holder">
                    <form id="contact_form" name="form1" className="form-border" method="post" action="#">

                      <label>Name</label>
                      <input type="text" name="name" id="name" className="form-control" />

                      <label>Email <span className="req">*</span></label>
                      <input type="text" name="email" id="email" className="form-control" />
                      <div id="error_email" className="error">Please check your email</div>

                      <label>Message <span className="req">*</span></label>
                      <textarea cols={10} rows={10} name="message" id="message" className="form-control"></textarea>
                      <div id="error_message" className="error">Please check your message</div>
                      <div id="mail_success" className="success">Thank you. Your message has been sent.</div>
                      <div id="mail_failed" className="error">Error, email not sent</div>

                      <p id="btnsubmit">
                        <input type="submit" id="send" value="Send" className="btn-main" /></p>
                    </form>
                  </div>
                </div>
              </div>
            </div>

            <div className="col-lg-4">
              <div className="widget widget-post">
                <h4>Popular Posts</h4>
                <ul className="de-bloglist-type-1">
                  <li>
                    <div className="d-image">
                      <img src="/images/blog-thumbnail/1.webp" alt="" />
                    </div>
                    <div className="d-content">
                      <Link href="/blog/single"><h4>Sustainable Waste Management Strategies for a Cleaner, Greener, and Healthier Planet</h4></Link>
                      <div className="d-date">January 15, 2023</div>
                    </div>
                  </li>
                  <li>
                    <div className="d-image">
                      <img src="/images/blog-thumbnail/2.webp" alt="" />
                    </div>
                    <div className="d-content">
                      <Link href="/blog/single"><h4>Innovative Waste Management Solutions to Reduce Pollution and Promote Sustainability</h4></Link>
                      <div className="d-date">January 15, 2023</div>
                    </div>
                  </li>
                  <li>
                    <div className="d-image">
                      <img src="/images/blog-thumbnail/3.webp" alt="" />
                    </div>
                    <div className="d-content">
                      <Link href="/blog/single"><h4>Community Engagement in Waste Management: Empowering Citizens for a Cleaner Future</h4></Link>
                      <div className="d-date">January 15, 2023</div>
                    </div>
                  </li>
                  <li>
                    <div className="d-image">
                      <img src="/images/blog-thumbnail/4.webp" alt="" />
                    </div>
                    <div className="d-content">
                      <Link href="/blog/single"><h4>The Role of Technology in Modern Waste Management Systems and Operations</h4></Link>
                      <div className="d-date">January 15, 2023</div>
                    </div>
                  </li>
                </ul>
              </div>

              <div className="widget widget-text">
                <h4>About Us</h4>
                <p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.</p>
              </div>

              <div className="widget widget_tags">
                <h4>Tags</h4>
                <ul>
                  <li><Link href="#link">Art</Link></li>
                  <li><Link href="#link">Application</Link></li>
                  <li><Link href="#link">Design</Link></li>
                  <li><Link href="#link">Entertainment</Link></li>
                  <li><Link href="#link">Internet</Link></li>
                  <li><Link href="#link">Marketing</Link></li>
                  <li><Link href="#link">Multipurpose</Link></li>
                  <li><Link href="#link">Music</Link></li>
                  <li><Link href="#link">Print</Link></li>
                  <li><Link href="#link">Programming</Link></li>
                  <li><Link href="#link">Responsive</Link></li>
                  <li><Link href="#link">Website</Link></li>
                </ul>
              </div>
            </div>
          </div>
        </div>
      </section>
    </>
  );
}
