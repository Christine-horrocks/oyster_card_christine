require 'station'

describe Station do
  it 'expects to display name and zone variable' do
    station = Station.new('aldgate', 1)
    expect(station.name).to eq 'aldgate'
    expect(station.zone).to eq 1
  end
end
