# list of samples
sounds = [:elec_twang, :perc_bell, :elec_chime, :misc_burp]

# granular glitchy sounds
in_thread do
  with_fx :echo do |echo|
    with_fx :pan do |pan|
      with_fx :reverb do |reverb|
        # loop glitchy sounds
        live_loop :burp do
          # change effects with random parameters
          control echo, decay: rrand(1,2)
          control pan, pan: rrand(-1,1)
          control reverb, mix: rrand(0.3,1), room: rrand(0,1), damp: rrand(0,1)
          
          # pick a random sample from the list and randomise its volume, playrate, beginning/end.
          sample choose(sounds), amp: rrand(0.3,1), rate: rrand(-1,30), start: rrand(0,1), finish: rrand(0,1)
          sleep rrand(0, 0.4)
        end
      end
    end
  end
end

# play the eerie background synth at the same time
in_thread do
  # with a lot of reverb!
  with_fx :reverb, room: 1, damp: 0.8 do
    live_loop :atmo do
      use_synth :zawa
      play 50, attack: 2, pulse_width: rrand(0.2,0.7), sustain: 2, cutoff: 45, release: 2
      sleep 5.5
    end
  end
end