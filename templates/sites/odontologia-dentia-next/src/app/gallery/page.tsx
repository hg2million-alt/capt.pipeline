'use client';

import Link from 'next/link';
import { useState } from 'react';

export default function Gallery() {
  const [filter, setFilter] = useState('*');

  const galleryItems = [
    { id: 1, category: 'facilities', image: '/images/gallery/l1.webp' },
    { id: 2, category: 'facilities', image: '/images/gallery/l2.webp' },
    { id: 3, category: 'facilities', image: '/images/gallery/l3.webp' },
    { id: 4, category: 'facilities', image: '/images/gallery/l4.webp' },
    { id: 5, category: 'facilities', image: '/images/gallery/l5.webp' },
    { id: 6, category: 'dentists', image: '/images/gallery/l6.webp' },
    { id: 7, category: 'dentists', image: '/images/gallery/l7.webp' },
    { id: 8, category: 'dentists', image: '/images/gallery/l8.webp' },
    { id: 9, category: 'services', image: '/images/gallery/l9.webp' },
    { id: 10, category: 'services', image: '/images/gallery/l10.webp' },
    { id: 11, category: 'services', image: '/images/gallery/l11.webp' },
    { id: 12, category: 'services', image: '/images/gallery/l12.webp' },
  ];

  const filteredItems = filter === '*' 
    ? galleryItems 
    : galleryItems.filter(item => item.category === filter);

  return (
    <>
      <section id="subheader" className="bg-color-op-1 text-center">
        <div className="container relative z-2">
          <div className="row align-items-center">
            <div className="col-lg-12">
              <h1 className="wow fadeInUp">Gallery</h1>
              <div className="border-bottom my-3"></div>
              <ul className="crumb wow fadeInDown">
                <li><Link href="/">Home</Link></li>
                <li className="active">Gallery</li>
              </ul>
            </div>
          </div>
        </div>
      </section>
      
      <section id="section-gallery" className="bg-light">
        <div className="container">

          <div className="row">
            <div className="col-md-12 text-center">
              <ul id="filters" className="wow fadeInUp" data-wow-delay="0s">
                <li><a href="#" onClick={(e) => { e.preventDefault(); setFilter('*'); }} className={filter === '*' ? "selected" : ""}>View All</a></li>
                <li><a href="#" onClick={(e) => { e.preventDefault(); setFilter('dentists'); }} className={filter === 'dentists' ? "selected" : ""}>dentists</a></li>
                <li><a href="#" onClick={(e) => { e.preventDefault(); setFilter('facilities'); }} className={filter === 'facilities' ? "selected" : ""}>facilities</a></li>
                <li><a href="#" onClick={(e) => { e.preventDefault(); setFilter('services'); }} className={filter === 'services' ? "selected" : ""}>services</a></li>
              </ul>
            </div>
          </div>

          <div id="gallery" className="row g-3 wow fadeIn" data-wow-delay=".3s">
            {filteredItems.map(item => (
              <div key={item.id} className={`col-md-3 col-sm-6 col-12 item ${item.category}`}>
                <a href={item.image} className="image-popup d-block hover">
                  <div className="relative overflow-hidden rounded-1">
                    <div className="absolute start-0 w-100 hover-op-1 p-5 abs-middle z-2 text-center text-white z-3">
                      View
                    </div>
                    <div className="absolute start-0 w-100 h-100 overlay-black-5 hover-op-1 z-2"></div>
                    <img src={item.image} className="w-100 hover-scale-1-2" alt="" />
                  </div>
                </a>
              </div>
            ))}
          </div>
        </div>
      </section>    
    </>
  );
}
