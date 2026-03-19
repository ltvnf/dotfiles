#include "weather.h"
#include "../sketchybar.h"

int main (int argc, char** argv) {
  float update_freq;
  if (argc < 3 || (sscanf(argv[2], "%f", &update_freq) != 1)) {
    printf("Usage: %s \"<event-name>\" \"<event_freq>\"\n", argv[0]);
    exit(1);
  }

  alarm(0);
  weather_info_t weather;

  // Setup the event in sketchybar
  char event_message[512];
  snprintf(event_message, 512, "--add event '%s'", argv[1]);
  sketchybar(event_message);

  char trigger_message[512];
  for (;;) {
    if (get_weather_info(&weather) == 0) {
      snprintf(trigger_message,
               512,
               "--trigger '%s' temp='%s' condition='%s'",
               argv[1],
               weather.temp,
               weather.condition);

      sketchybar(trigger_message);
    }

    usleep(update_freq * 1000000);
  }
  return 0;
}
