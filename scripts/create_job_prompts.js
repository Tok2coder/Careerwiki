// Node.js script to generate image prompts for jobs
const fs = require('fs');
const path = require('path');

function generatePrompt(jobNameEn) {
  // Job-specific actions and environments
  const jobMappings = {
    // Manufacturing & Construction
    'maker': {
      action: 'actively crafting and assembling',
      environment: 'woodworking shop filled with saws, hammers, drills, wood planks, measuring tools, and carpentry supplies'
    },
    'repairer': {
      action: 'actively repairing and refinishing',
      environment: 'maintenance workshop filled with tools, repair equipment, spare parts, and workbenches'
    },
    'assembler': {
      action: 'actively assembling and inspecting',
      environment: 'production facility filled with conveyor belts, quality control stations, assembly tools, and finished products'
    },
    'technician': {
      action: 'actively calibrating and adjusting',
      environment: 'technical workshop filled with specialized equipment, testing devices, diagnostic tools, and precision instruments'
    },
    'engineer': {
      action: 'actively designing and analyzing',
      environment: 'engineering office filled with computer workstations, technical drawings, blueprints, and prototype models'
    },
    'mechanic': {
      action: 'actively repairing and servicing',
      environment: 'automotive garage filled with tools, vehicle parts, diagnostic equipment, and service bays'
    },
    'electrician': {
      action: 'actively installing and wiring',
      environment: 'electrical workshop filled with cables, circuit breakers, testing equipment, and electrical panels'
    },
    'welder': {
      action: 'actively welding and fabricating',
      environment: 'metalworking shop filled with welding equipment, metal sheets, safety gear, and fabrication tools'
    },

    // IT & Technology
    'developer': {
      action: 'actively coding and debugging',
      environment: 'modern office filled with computer screens, keyboards, programming books, coffee mugs, and ergonomic workstations'
    },
    'analyst': {
      action: 'actively analyzing data and reports',
      environment: 'data center filled with servers, multiple monitors displaying analytics, charts, and technical documentation'
    },
    'specialist': {
      action: 'actively operating specialized equipment',
      environment: 'high-tech laboratory filled with advanced equipment, control panels, LED screens, and technical instruments'
    },
    'administrator': {
      action: 'actively managing and monitoring',
      environment: 'server room filled with computer racks, monitoring screens, networking equipment, and control panels'
    },
    'designer': {
      action: 'actively creating and designing',
      environment: 'creative studio filled with computer workstations, design software, inspiration boards, and digital tablets'
    },
    'programmer': {
      action: 'actively coding and testing',
      environment: 'software development office filled with multiple screens, keyboards, coding books, and development tools'
    },

    // Healthcare & Medical
    'nurse': {
      action: 'actively caring for patients',
      environment: 'hospital ward filled with medical equipment, patient beds, monitoring devices, and medical supplies'
    },
    'therapist': {
      action: 'actively treating and assisting',
      environment: 'rehabilitation center filled with therapy equipment, exercise machines, treatment tables, and medical supplies'
    },
    'technologist': {
      action: 'actively operating medical equipment',
      environment: 'medical laboratory filled with diagnostic machines, test tubes, microscopes, and analysis equipment'
    },
    'assistant': {
      action: 'actively supporting medical procedures',
      environment: 'medical office filled with examination tables, medical instruments, patient records, and care supplies'
    },
    'pharmacist': {
      action: 'actively preparing and dispensing',
      environment: 'pharmacy filled with medication bottles, prescription labels, compounding equipment, and pharmaceutical supplies'
    },

    // Service & Hospitality
    'manager': {
      action: 'actively overseeing and directing',
      environment: 'professional office filled with desks, computers, meeting rooms, organizational charts, and business documents'
    },
    'clerk': {
      action: 'actively processing and organizing',
      environment: 'office environment filled with desks, filing cabinets, computers, printers, and administrative supplies'
    },
    'worker': {
      action: 'actively performing service duties',
      environment: 'service facility filled with specialized equipment, tools, supplies, and customer service areas'
    },
    'operator': {
      action: 'actively operating machinery',
      environment: 'industrial facility filled with control panels, machinery, monitoring systems, and operational equipment'
    },
    'driver': {
      action: 'actively driving and navigating',
      environment: 'vehicle interior filled with steering wheels, dashboards, navigation systems, and transportation equipment'
    },

    // Education & Creative
    'teacher': {
      action: 'actively teaching and guiding',
      environment: 'classroom filled with desks, educational materials, teaching aids, whiteboards, and learning resources'
    },
    'instructor': {
      action: 'actively demonstrating and training',
      environment: 'training facility filled with equipment, instructional materials, practice areas, and teaching supplies'
    },
    'artist': {
      action: 'actively creating artwork',
      environment: 'art studio filled with easels, paints, brushes, canvases, palettes, and artistic supplies'
    },
    'musician': {
      action: 'actively playing and performing',
      environment: 'music studio filled with musical instruments, recording equipment, sheet music, and audio gear'
    },
    'coach': {
      action: 'actively training and instructing',
      environment: 'sports facility filled with exercise equipment, training aids, scoreboards, and athletic supplies'
    },

    // Food & Culinary
    'chef': {
      action: 'actively cooking and preparing',
      environment: 'professional kitchen filled with stoves, ovens, cutting boards, pots, pans, and culinary tools'
    },
    'baker': {
      action: 'actively baking and decorating',
      environment: 'bakery kitchen filled with ovens, mixing bowls, decorating tools, flour sacks, and baking supplies'
    },

    // Cleaning & Maintenance
    'cleaner': {
      action: 'actively cleaning and maintaining',
      environment: 'cleaning facility filled with cleaning supplies, mops, vacuums, cleaning chemicals, and maintenance equipment'
    },

    // Default fallback
    'default': {
      action: 'actively performing professional duties',
      environment: 'professional workplace filled with relevant tools, equipment, and work materials'
    }
  };

  // Find matching job type
  const jobLower = jobNameEn.toLowerCase();
  let matchedJob = jobMappings.default;

  for (const [key, value] of Object.entries(jobMappings)) {
    if (jobLower.includes(key) && key !== 'default') {
      matchedJob = value;
      break;
    }
  }

  return `A small cute baby beaver with tiny teeth, big round glossy eyes, soft rounded cheeks, short limbs, light-brown fluffy fur and a creamy belly, drawn in simple 2D cartoon style, ${matchedJob.action} in a ${matchedJob.environment}, the beaver appearing small at about 20% of the frame, rendered in 2D stylized realism with soft painterly shading, gentle gradients, atmospheric haze, cinematic rim light using a dark-mode palette of deep navy, muted violet, soft teal glow accents with rich background depth.`;
}

// Example usage
console.log('Sample prompts:');
console.log('Furniture Maker and Repairer:', generatePrompt('Furniture Maker and Repairer'));
console.log('Virtual Reality Specialist:', generatePrompt('Virtual Reality Specialist'));
console.log('Singer:', generatePrompt('Singer'));


