#include "IAudioRenderer.hpp"
#include <opus/opus_multistream.h>
#pragma once

class RetroAudioRenderer: public IAudioRenderer {
public:
    RetroAudioRenderer() {};
    ~RetroAudioRenderer();
    
    int init(int audio_configuration, const POPUS_MULTISTREAM_CONFIGURATION opus_config, void *context, int ar_flags) override;
    void cleanup() override;
    void decode_and_play_sample(char *sample_data, int sample_length) override;
    int capabilities() override;
    
private:
    OpusMSDecoder* m_decoder = nullptr;
    short* m_buffer = nullptr;
};
