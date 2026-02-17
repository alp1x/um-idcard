// convertImage from txd to base64: https://github.com/BaziForYou/MugShotBase64
export function convertImage(
    txd: string,
    outputFormat: string = 'image/png'
): Promise<string> {
    return new Promise<string>((resolve, reject) => {
        const img = new Image();
        img.crossOrigin = 'Anonymous';

        img.onload = () => {
            try {
                const canvas = document.createElement('canvas');
                const ctx = canvas.getContext('2d', { alpha: true });
                if (!ctx) throw new Error('Failed to get 2D context.');

                canvas.width = img.naturalWidth;
                canvas.height = img.naturalHeight;
                ctx.imageSmoothingEnabled = true;
                ctx.imageSmoothingQuality = 'high';
                ctx.drawImage(img, 0, 0);

                resolve(canvas.toDataURL(outputFormat));
                canvas.remove();
            } catch (error) {
                reject(error);
            } finally {
                img.remove();
            }
        };

        img.onerror = () => reject(new Error('Failed to load image.'));
        img.src = `https://nui-img/${txd}/${txd}`;
    });
}

function base64ToBlob(base64: string): Blob {
    const [header, data] = base64.split(',');
    const mime = header.match(/:(.*?);/)?.[1] ?? 'image/png';
    const bytes = atob(data);
    const buffer = new Uint8Array(bytes.length);

    for (let i = 0; i < bytes.length; i++) {
        buffer[i] = bytes.charCodeAt(i);
    }

    return new Blob([buffer], { type: mime });
}

export async function uploadToFivemanage(
    base64: string,
    presignedUrl: string
): Promise<string | null> {
    try {
        const blob = base64ToBlob(base64);
        const formData = new FormData();
        formData.append('file', blob, 'mugshot.png');

        const res = await fetch(presignedUrl, {
            method: 'POST',
            body: formData,
        });

        const json = await res.json();
        return json?.data?.url ?? null;
    } catch (err) {
        console.error('Upload failed:', err);
        return null;
    }
}
