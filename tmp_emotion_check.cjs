const fs = require('fs');
const scenarios = ['analytical_user','stability_seeker','internal_conflict','creative_user','low_can_user','comprehensive_test'];
const EMOTION_PATTERNS = [
  /어떤 (?:감정|느낌|기분)/,
  /(?:느꼈|느끼셨|느끼나|느끼시|느끼는|느끼고|느끼세|느끼실)/,
  /(?:감정이|기분이|마음이) (?:어떠|어떤|어땠)/,
  /불안[^정]|답답|두렵|무섭|화가|짜증|슬프|우울|외롭/,
  /감정적으로|정서적으로|내면적으로|심리적으로/,
  /어떤 (?:마음|심정|기분)/,
  /(?:힘드셨|힘들었|힘들게|괴로|고통스러|지치|지친|속상|서운)/,
  /마음이 (?:어떠|움직|끌)/,
  /(?:감정을|감정이|기분이|기분은) (?:느|드)/,
  /어떤 (?:감정|기분)(?:을|이|은)/,
  /마음속으로|마음 속에|가슴이 (?:뛰|답답|아프|떨)/,
  /(?:행복|불행|만족|불만족)(?:하셨|했|한 적|감을)/,
  /(?:스트레스|압박감|부담감)(?:을|이|는|도)? (?:느끼|받으|많이)/,
];

scenarios.forEach(function(s) {
  const d = JSON.parse(fs.readFileSync('docs/e2e-results/full-e2e/' + s + '.json', 'utf8'));
  console.log('\n=== ' + s + ' ===');
  d.rounds.forEach(function(r, ri) {
    r.questions.forEach(function(q, qi) {
      const isEm = EMOTION_PATTERNS.some(function(p) { return p.test(q.questionText); });
      if (isEm) {
        console.log('  R' + (ri+1) + 'Q' + (qi+1) + ' [EMO]: ' + q.questionText.substring(0, 100));
      }
    });
  });
});
