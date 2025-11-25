#include "token.hpp"

const char *msg = 
  "{\"symbol\":\"BTCUSDT\",\"priceChange\":\"-1444.86000000\",\"priceChangePercent\":\"-1.630\",\"weightedAvgPrice\":\"87667.93943674\",\"openPrice\":\"88652.88000000\",\"highPrice\":\"89228.00000000\",\"lowPrice\":\"86116.00000000\",\"lastPrice\":\"87208.02000000\",\"volume\":\"20153.59973000\",\"quoteVolume\":\"1766824560.56199970\",\"openTime\":1764010920000,\"closeTime\":1764097365232,\"firstId\":5561869887,\"lastId\":5566673662,\"count\":4803776}";

int main() {
  Token t("BTCUSDT");
  int iter = 10;

  t.request();
  std::vector<std::string> res = t.splitResponse();

  for (int i = 0; i < res.size(); i++) {
    std::cout << res[i] << '\n';
  }

  return 0;
}
