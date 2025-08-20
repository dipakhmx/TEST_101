import { useState, useEffect } from "react";
import { motion } from "framer-motion";
import { Card, CardContent } from "@/components/ui/card";
import { Button } from "@/components/ui/button";

const katakanaLevels = {
  1: ["ア", "イ", "ウ", "エ", "オ"],
  2: ["カ", "キ", "ク", "ケ", "コ"],
  3: ["サ", "シ", "ス", "セ", "ソ"],
  4: ["タ", "チ", "ツ", "テ", "ト"],
  5: ["ナ", "ニ", "ヌ", "ネ", "ノ"],
  6: ["ハ", "ヒ", "フ", "ヘ", "ホ"],
  7: ["マ", "ミ", "ム", "メ", "モ"],
  8: ["ヤ", "ユ", "ヨ", "ラ", "リ", "ル", "レ", "ロ", "ワ", "ヲ", "ン", "ャ", "ュ", "ョ", "ッ", "キャ", "シュ", "ティ", "ファ", "ウィ"],
};

const romajiMap: Record<string, string> = {
  "ア": "A", "イ": "I", "ウ": "U", "エ": "E", "オ": "O",
  "カ": "KA", "キ": "KI", "ク": "KU", "ケ": "KE", "コ": "KO",
  "サ": "SA", "シ": "SHI", "ス": "SU", "セ": "SE", "ソ": "SO",
  "タ": "TA", "チ": "CHI", "ツ": "TSU", "テ": "TE", "ト": "TO",
  "ナ": "NA", "ニ": "NI", "ヌ": "NU", "ネ": "NE", "ノ": "NO",
  "ハ": "HA", "ヒ": "HI", "フ": "FU", "ヘ": "HE", "ホ": "HO",
  "マ": "MA", "ミ": "MI", "ム": "MU", "メ": "ME", "モ": "MO",
  "ヤ": "YA", "ユ": "YU", "ヨ": "YO", "ラ": "RA", "リ": "RI", "ル": "RU", "レ": "RE", "ロ": "RO",
  "ワ": "WA", "ヲ": "WO", "ン": "N", "ャ": "ya", "ュ": "yu", "ョ": "yo", "ッ": "pause",
  "キャ": "KYA", "シュ": "SHU", "ティ": "TI", "ファ": "FA", "ウィ": "WI",
};

export default function KatakanaAdventure() {
  const [level, setLevel] = useState(1);
  const [characters, setCharacters] = useState<string[]>([]);
  const [quizChar, setQuizChar] = useState<string | null>(null);
  const [feedback, setFeedback] = useState<string>("");
  const [score, setScore] = useState(0);

  useEffect(() => {
    setCharacters(katakanaLevels[level]);
    setNewQuiz();
  }, [level]);

  const setNewQuiz = () => {
    const chars = katakanaLevels[level];
    const randomChar = chars[Math.floor(Math.random() * chars.length)];
    setQuizChar(randomChar);
    setFeedback("");
  };

  const checkAnswer = (answer: string) => {
    if (quizChar && romajiMap[quizChar] === answer) {
      setFeedback("✅ Correct!");
      setScore(score + 1);
    } else {
      setFeedback(`❌ Wrong! Correct: ${quizChar} = ${romajiMap[quizChar]}`);
    }
    setTimeout(setNewQuiz, 1000);
  };

  return (
    <div className="p-6 grid gap-6 text-center">
      <h1 className="text-2xl font-bold">Kana Quest: Katakana Adventure</h1>
      <p className="text-lg">Level {level}: Practice Katakana</p>
      <p className="text-md">Score: {score}</p>

      {quizChar && (
        <motion.div
          key={quizChar}
          initial={{ opacity: 0, scale: 0.8 }}
          animate={{ opacity: 1, scale: 1 }}
          className="flex justify-center"
        >
          <Card className="p-10 text-6xl font-bold">{quizChar}</Card>
        </motion.div>
      )}

      <div className="grid grid-cols-2 sm:grid-cols-3 gap-3">
        {characters.map((char) => (
          <Button
            key={char}
            onClick={() => checkAnswer(romajiMap[char])}
            className="p-4 text-lg"
          >
            {romajiMap[char]}
          </Button>
        ))}
      </div>

      <p className="text-lg font-medium mt-2">{feedback}</p>

      <div className="flex justify-center gap-3 mt-4">
        {level > 1 && (
          <Button onClick={() => setLevel(level - 1)}>⬅ Prev</Button>
        )}
        {level < 8 && (
          <Button onClick={() => setLevel(level + 1)}>Next ➡</Button>
        )}
      </div>
    </div>
  );
}
