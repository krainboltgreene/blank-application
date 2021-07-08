const TEXT_STYLE = {
  whiteSpace: "pre",
  fill: "rgb(0, 0, 0)",
  fontFamily: "monospace",
  fontSize: "28px",
} as const;
const CARD_STYLE = {
  fill: "rgb(0, 0, 0)",
} as const;
const STAT_STYLE = {
  fill: "rgb(216, 216, 216)",
} as const;

interface CardProperties {
  name: string;
  cost: number;
  description: string;
  leadership: number;
  wealth: number;
  planning: number;
  guile: number;
}

export default function Card (properties: Readonly<CardProperties>): JSX.Element {
  const {name} = properties;
  const {cost} = properties;
  const {description} = properties;
  const {leadership} = properties;
  const {wealth} = properties;
  const {planning} = properties;
  const {guile} = properties;

  return <svg viewBox="0 0 700 900" width="700" height="900" xmlns="http://www.w3.org/2000/svg" css={CARD_STYLE}>
    <text x="179.538" y="92.135" css={TEXT_STYLE}>{name}</text>
    <text x="612.838" y="68.746" css={TEXT_STYLE}>{cost}</text>
    <text x="294.318" y="609.869" css={TEXT_STYLE}>{description}</text>
    <rect x="26.765" y="388.662" width="106.843" height="471.699" css={STAT_STYLE} />
    <text x="2.056" y="450.433" css={TEXT_STYLE}>{leadership}</text>
    <text x="30.931" y="575.264" css={TEXT_STYLE}>{wealth}</text>
    <text x="77.192" y="695.564" css={TEXT_STYLE}>{planning}</text>
    <text x="43.296" y="797.054" css={TEXT_STYLE}>{guile}</text>
    <image href="assets/images/card-art.jpeg" x="0" y="0" height="50px" width="50px" />
  </svg>;
}
